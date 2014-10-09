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
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token) if self.facebook_access_token
  end
  
  def self.find_by_facebook_token(token)
    token = Facebook.oauth.exchange_access_token_info(token)
    graph_api = Koala::Facebook::API.new(token['access_token'])
    me = graph_api.get_object('me')
    
    person = Person.find_or_initialize_by facebook_id: me['id'].to_i
    
    person.user.facebook_access_token = token['access_token']
    person.user.facebook_expires_in = token['expires'].to_i
    
    person.assign_facebook_attributes me

    person.save
    person.user.save
    
    person.user
  end
end