class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include Concerns::FacebookImportable



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
end