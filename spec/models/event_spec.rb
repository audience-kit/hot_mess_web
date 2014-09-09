require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "should be created with valid attributes" do
    event = build(:event)

    expect(event.save).to be_truthy
  end

  it "should not be created with invalid attributes" do
    event = build(:event)
    event.name = nil

    expect(event.save).to be_falsey
  end
end
