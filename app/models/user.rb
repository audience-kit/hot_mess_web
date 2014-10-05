class User
  include Mongoid::Document
  include Mongoid::Timestamps

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

  def to_s
    self.name
  end
  
  def update_from_facebook(me = nil)

    if me.nil?
      me = facebook_graph.get_object('me').with_indifferent_access
    end

    Rails.logger.debug "\tQuery for Facebook 'me' object #{me.inspect}"

    self.email = me[:email]

    if self.person.nil?
      self.person = Person.new
    end

    self.person.assign_facebook_attributes me

    self.person.save
  end

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token)
  end
end