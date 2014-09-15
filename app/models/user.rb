class User
  include Mongoid::Document

  field :facebook_id, type: Integer
  field :facebook_access_token, type: String
  field :facebook_expires_in, type: Integer
  field :email, type: String
  field :is_admin, type: Boolean, default: false

  has_one :person

  validates_presence_of :facebook_id
  validates_presence_of :person
  validates_associated :person


  def update_from_facebook(me = nil)

    if me.nil?
      me = facebook_graph.get_object('me').with_indifferent_access
    end

    Rails.logger.debug "\tQuery for Facebook 'me' object #{me.inspect}"

    self.email = me[:email]

    if self.person.nil?
      self.person = Person.new
    end

    self.person.update_from_facebook me

    self.person.save
  end

  def name
    person.name
  end

  def to_s
    self.name
  end

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token)
  end
end