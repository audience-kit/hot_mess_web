class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable
  
  GENDER_MALE                 = 'male'
  GENDER_FEMALE               = 'female'

  field :public?,             type: Boolean,  default: false
  field :name,                type: String
  field :first_name,          type: String
  field :last_name,           type: String
  field :middle_name,         type: String
  field :locale,              type: String
  field :timezone,            type: Integer
  field :email_address,       type: String
  field :gender,              type: String
  field :link,                type: String
  field :facebook_id,         type: Integer
  field :facebook_verified,   type: Boolean
  field :facebook_likes,      type: Integer
  field :soundcloud_id,       type: Integer
  
  belongs_to :user
  
  validates_presence_of :name
  validates_presence_of :email_address
  
  scope :public,              ->{ where(public?: true) }
  
  facebook_field_mapping      facebook_id: :id, facebook_verified: :verified, facebook_likes: :likes

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