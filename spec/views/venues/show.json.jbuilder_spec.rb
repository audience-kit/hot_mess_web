require 'rails_helper'

RSpec.describe "venues/show.json.jbuilder", type: :view do
  before(:each) do
    venue = create :venue
    venue.events = [ create(:event, venue: venue), create(:event, venue: venue) ]
    
    @venue = assign :venue, venue
  end

  it "renders a venue" do
    render
    
    result = JSON.parse(rendered)
    
    expect(result['url']).to_not be_nil
    expect(result['pictures'].count).to_not eq(0)
    expect(result['name']).to eq @venue.name
  end
end
