require 'rails_helper'

RSpec.describe Venue, :type => :model do
  it "should not be valid without values" do
    venue = Venue.new

    expect(venue.valid?).to be_falsey
  end

  it "should be valid with valid values" do
    venue = build(:venue)

    expect(venue.valid?).to be_truthy
  end

  it "should be invalid when the name is invalid" do
    venue = build(:venue)
    venue.name = nil
    expect(venue.valid?).to be_falsey
  end
end
