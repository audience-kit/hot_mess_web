class Event
  include Mongoid::Document

  belongs_to :venue

  field :name, type: String
  field :description, type: String
  field :start_at, type: DateTime
  field :end_at, type: DateTime
  field :minimum_age, type: Integer

  validates_presence_of :name
  validates_presence_of :start_at
  validates_presence_of :end_at
end