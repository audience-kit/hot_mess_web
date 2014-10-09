require 'spec_helper'

RSpec.describe Person, type: :model do
  it "should be in the public scope if it is public" do
    person = create(:public_person)
    
    expect(Person.are_public).to include(person)
  end
  
  it "should be able to import events" do
    Mock::Facebook.mock_facebook_api(self)
    user = create :user
    venue = Venue.import_from_facebook('neighboursseattle')
    
    expect{ user.person.import_facebook_events }.to change{ Event.all.count }.from(0).to(1)
  end
end