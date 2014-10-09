module Concerns::FacebookImportable
  extend ActiveSupport::Concern
  
  FACEBOOK_ASSIGNING_ATTRIBUTES = :"@_facebook_importable_assigning"
  
  included do
    @facebook_mapping = Hash.new
  end
  
  def assign_facebook_attributes(attributes)
    return if self.instance_variable_get FACEBOOK_ASSIGNING_ATTRIBUTES
    self.instance_variable_set FACEBOOK_ASSIGNING_ATTRIBUTES, true
    
    mapping = self.class.facebook_mapping
    mapped_keys = Hash[attributes.map {|k, v| [(mapping[k.to_sym] || k).to_sym, v] }]
    selected_keys = mapped_keys.reject { |k, v| not self.class.fields[k.to_s] }
    
    assign_attributes(selected_keys)
    
    remaining_keys = attributes.reject { |k, v| selected_keys.include? k }
    
    self.class.relations.each do |key, relation|
      value = self.send key.to_sym
      
      if value && value.class.ancestors.include?(Concerns::FacebookImportable)
        value.assign_facebook_attributes remaining_keys
      end
    end
    self.instance_variable_set FACEBOOK_ASSIGNING_ATTRIBUTES, false
  end
  
  def update_facebook_pictures
    return unless self.respond_to? :pictures
    
    Rails.logger.info "Updating picture for #{self.to_s}"
    self.pictures = []
    
    picture_graphs = Facebook.application_graph.batch do |batch|    
      Picture::PICTURE_TYPES.each do |type|
        batch.get_object("/#{self.facebook_id}/picture?redirect=false&type#{type.to_s}")
      end
    end
    
    picture_graphs = picture_graphs.zip(Picture::PICTURE_TYPES)
    picture_graphs.each do |graph, type|
      picture = self.pictures.build
      picture.type = type
      picture.assign_facebook_attributes graph['data']
    end
    
    self.save
  end
  
  module ClassMethods
    def facebook_ids
      field :facebook_ids,         type: Array
    end
    
    def facebook_id
      field :facebook_id,          type: Integer
    end
    
    def facebook_map_attributes(mapping)
      @facebook_mapping.merge!(mapping)
    end
    
    def facebook_map_attribute(key, value)
      @facebook_mapping[key.to_sym] = value.to_sym
    end
    
    def facebook_mapping
      @facebook_mapping
    end
    
    def find_by_facebook_id(id)
      if self.fields['facebook_id']
        by_id = self.where(facebook_id: id).to_a
  
        return by_id.first if by_id.any?
      end
  
      if self.fields['facebook_ids']
        with_id = self.where(:facebook_ids.in => [ id ]).to_a
      
        with_id.any? ? with_id.first : nil
      end
    end
    
    def import_from_facebook(id, graph = nil)
      graph ||= Facebook.application_graph
    
      graph_object = graph.get_object(id)
      return unless graph_object
    
      id = graph_object['id'].to_i
      venue = Venue.find_or_initialize_by(facebook_id: id)
      venue.assign_facebook_attributes graph_object
      venue.save
    
      venue
    end
  end
end