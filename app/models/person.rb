class Person
  include Mongoid::Document

  field :facebook_id, type: Integer
  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :middle_name, type: String
  field :link, type: String
  field :facebook_verified, type: Boolean
  field :locale, type: String
  field :timezone, type: Integer
  field :email_address, type: String
  field :gender, type: String

  GENDER_MALE = 'male'
  GENDER_FEMALE = 'female'

  belongs_to :user

  def update_from_facebook(me)
    self.facebook_id        = me[:id].to_i
    self.first_name         = me[:first_name]
    self.middle_name        = me[:middle_name]
    self.last_name          = me[:last_name]
    self.name               = me[:name]
    self.link               = me[:link]
    self.gender             = me[:gender]
    self.timezone           = me[:timezone]
    self.facebook_verified  = me[:verified]
    self.locale             = me[:locale]
  end
end