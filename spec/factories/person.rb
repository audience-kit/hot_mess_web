FactoryGirl.define do
  factory :person do
    first_name "Jonny"
    last_name "Appleseed"
    name "Jonny Appleseed"
    public? false
    
    factory :public_person do
      public? true
    end
  end
end