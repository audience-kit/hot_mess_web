class Venue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_id, type: Integer
  field :name, type: String
  field :about, type: String
  field :attire, type: String
  field :checkins, type: Integer
  field :description, type: String
  field :website, type: String
  field :were_here_count, type: Integer
  field :phone, type: String
  field :imported_at, type: DateTime
  field :link, type: String

  belongs_to :imported_by, class_name: 'User'
  belongs_to :picture

  embeds_one :location
  embeds_one :cover

  validates_presence_of :name
  validates_associated :picture

  def facebook_url
    if self['username']
      "http://facebook.com/#{self['username']}"
    elsif self['link']
      self.link
    end
  end
end
