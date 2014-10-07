require 'spec_helper'

RSpec.describe Person, type: :model do
  it "should be in the public scope if it is public" do
    person = create(:public_person)
    
    expect(Person.are_public).to include(person)
  end
end