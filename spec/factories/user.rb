FactoryGirl.define do
  factory :user do
    facebook_id     10203595242113373
    email           'rickmark@outlook.com'
    is_admin        false

    factory :admin do
      is_admin      true
    end
  end
end