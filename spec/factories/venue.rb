# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "Everafter"
    phone "+15098921403"
    location Address.new( address_line: '556 Harvard Ave E', city: 'Seattle', state: 'WA', zip: '98102' )
  end
end
