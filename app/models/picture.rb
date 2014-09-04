class Picture
  include Mongoid::Document

  field :url, type: String
  field :is_silhouette, type: Boolean
  field :width, type: Integer
  field :height, type: Integer

end