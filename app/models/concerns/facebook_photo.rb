module Concerns::FacebookPhoto
  extend ActiveSupport::Concern
  include Concerns::FacebookImportable
  
  included do
    embeds_many :pictures, as: :photographic
  end
  
  def update_facebook_pictures(graph = nil)
    return unless self.respond_to? :pictures
    graph ||= Facebook.application_graph
    
    Rails.logger.info "Updating picture for #{self.to_s}"
    self.pictures = []
    
    picture_graphs = graph.batch do |batch|    
      Picture::PICTURE_TYPES.each do |type|
        batch.get_object("/#{self.facebook_id}/picture?redirect=false&type=#{type.to_s}")
      end
    end
    
    picture_graphs = picture_graphs.zip(Picture::PICTURE_TYPES)
    picture_graphs.each do |graph, type|
      if graph['data']
        picture = self.pictures.build
        picture.type = type
        picture.assign_facebook_attributes graph['data']
      end
    end
    
    self.save
  end
  
  def picture(size = :normal)
    self.pictures.where(type: size.to_s).first
  end
  
  module ClassMethod

  end
end