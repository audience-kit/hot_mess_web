require 'rails_helper'

RSpec.describe "events/show", :type => :view do
  before(:each) do
    @event = assign(:event, create(:event))
  end

  it "renders name in heading" do
    render

    assert_select 'h1.page-header', @event.name
  end
end
