FactoryGirl.define do
  factory :user do
    email           'rickmark@outlook.com'
    first_name "Jonny"
    last_name "Appleseed"
    is_admin        false
    person

    factory :admin do
      is_admin      true
    end
  end
end