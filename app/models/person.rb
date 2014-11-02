# This agrigate represents any person or persona entity in the system.
# 
# Persons are individuals that can be seen, or communicated with in person.  This includes all users of the system, as well as various personas.  Personas include alter-egos such as drag queens, stage names, and celebraties.  A persona can be tied to any number of socal media accounts or projections on the internet.
# @author rickmark
class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable
  include Concerns::FacebookPhoto
  
  GENDER_MALE                 = 'male'
  GENDER_FEMALE               = 'female'
  
  GENDERS = [ GENDER_MALE, GENDER_FEMALE ]

  field :name,                type: String
  field :locale,              type: String
  field :timezone,            type: Integer
  field :gender,              type: String
  field :link,                type: String
  field :facebook_verified,   type: Boolean
  field :facebook_likes,      type: Integer
  field :soundcloud_id,       type: Integer
  field :is_public,           type: Boolean,    default: false
  
  belongs_to :user,           autobuild: true
  
  delegate :to_s, to: :name
  
  validates_presence_of :name, :facebook_id
  
  scope :are_public, ->{ where(is_public: true) }
  
  facebook_id
  facebook_map_attributes facebook_id: :id, facebook_verified: :verified, facebook_likes: :likes
end