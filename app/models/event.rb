class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable

  field :facebook_id,         type: Integer
  field :name,                type: String
  field :description,         type: String
  field :start_time,          type: DateTime
  field :end_time,            type: DateTime
  field :updated_time,        type: DateTime
  field :owner_id,            type: Integer
  field :minimum_age,         type: Integer
  
  belongs_to :venue
  belongs_to :person

  validates_presence_of :name
  
  facebook_map_attributes :id => :facebook_id
end