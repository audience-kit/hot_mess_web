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
    
    self.class.relations.each do |key, relation|
      value = self.send key.to_sym
      
      if value && value.class.ancestors.include?(Concerns::FacebookImportable)
        value.assign_facebook_attributes attributes
      end
    end
    self.instance_variable_set FACEBOOK_ASSIGNING_ATTRIBUTES, false
  end
  
  module ClassMethods
    def facebook_map_attributes(mapping)
      @facebook_mapping.merge!(mapping)
    end
    
    def facebook_map_attribute(key, value)
      @facebook_mapping[key.to_sym] = value.to_sym
    end
    
    def facebook_mapping
      @facebook_mapping
    end
  end
end