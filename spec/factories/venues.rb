# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "Everafter"
    phone_number "+15098921403"
    address

    factory :venue_invalid_phone do
      phone_number "lk4829839"
    end
  end
end
