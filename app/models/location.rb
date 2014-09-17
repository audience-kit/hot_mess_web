class Location
  include Mongoid::Document

  field :city, type: String
  field :country, type: String
  field :state, type: String
  field :street, type: String
  field :zip, type: String
  field :latitude, type: Float
  field :longitude, type: Float

  def to_s
    "#{self.street} #{self.city}, #{self.state} #{self.zip}"
  end
end