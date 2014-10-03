class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::FacebookImportable
  
  GENDER_MALE                 = 'male'
  GENDER_FEMALE               = 'female'

  field :name,                type: String
  field :locale,              type: String
  field :timezone,            type: Integer
  field :gender,              type: String
  field :link,                type: String
  field :facebook_id,         type: Integer
  field :facebook_verified,   type: Boolean
  field :facebook_likes,      type: Integer
  field :soundcloud_id,       type: Integer
  field :is_public,           type: Boolean,    default: false
  
  belongs_to :user,           autobuild: true
  
  validates_presence_of :name
  
  scope :public, ->{ where(is_public: true) }
  
  facebook_field_mapping ({
    facebook_id: :id,
    facebook_verified: :verified,
    facebook_likes: :likes,
    user: {
        first_name: :first_name ,
        middle_name: :middle_name,
        last_name: :last_name
    }
  })
end