require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    @events = assign(:events, [
      create(:event),
      create(:event)
    ])
  end

  it "renders a list of events" do
    render
    assert_select ".event", count: 2
    assert_select ".event", text: @events[0].name
  end
end
