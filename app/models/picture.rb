class Picture
  include Mongoid::Document
  include Concerns::FacebookImportable
  
  embedded_in :photographic, polymorphic: true
  
  PICTURE_TYPES = [ :square, :small, :normal, :large ]

  field :url,             type: String
  field :is_silhouette,   type: Boolean
  field :width,           type: Integer
  field :height,          type: Integer
  field :type,            type: String
end