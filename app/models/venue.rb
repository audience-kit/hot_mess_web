class Venue
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable

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
  field :facebook_username, type: String

  belongs_to :imported_by, class_name: 'User'
  belongs_to :picture

  embeds_one :location
  embeds_one :cover

  validates_presence_of :name
  validates_associated :picture
  
  facebook_map_attributes :id => :facebook_id, :username => :facebook_username

  def facebook_url
    return "http://facebook.com/#{self.facebook_username}" if self.facebook_username
      
    self.link
  end
  
  def import_facebook_events(koala_client)
    events = koala_client.get_object("#{facebook_id}/events")
  end
  

end