# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    start_time "2014-09-02 23:35:57"
    end_time "2014-09-02 23:35:57"
    name "Some Really Cool Event"
    venue
  end
end
