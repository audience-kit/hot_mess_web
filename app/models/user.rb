class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookPrincipal
  include Concerns::FacebookPhoto
  
  field :first_name,              type: String
  field :last_name,               type: String
  field :middle_name,             type: String
  field :email,                   type: String
  field :is_admin,                type: Boolean,    default: false

  has_one                         :person,          autobuild: true

  validates_presence_of           :person
  validates_associated            :person

  delegate :to_s,                 to: :name
end