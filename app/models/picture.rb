class Picture
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url, type: String
  field :is_silhouette, type: Boolean
  field :width, type: Integer
  field :height, type: Integer

end