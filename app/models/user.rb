class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable
  
  field :first_name,              type: String
  field :last_name,               type: String
  field :middle_name,             type: String
  field :facebook_access_token,   type: String
  field :facebook_expires_in,     type: Integer
  field :email,                   type: String
  field :is_admin,                type: Boolean,    default: false

  has_one                         :person,          autobuild: true

  validates_presence_of           :person
  validates_associated            :person

  delegate :to_s, to: :name
  
  def update_from_facebook(me_graph = facebook_me_graph)
    self.assign_facebook_attributes me_graph
  end
  
  def facebook_me_graph
    facebook_graph.get_object('me').with_indifferent_access
  end

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token)
  end
end