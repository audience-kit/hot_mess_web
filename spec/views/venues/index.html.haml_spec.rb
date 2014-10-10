require 'rails_helper'

RSpec.describe "venues/index", :type => :view do
  before(:each) do
    @venues = assign(:venues, [
        create(:venue),
        create(:venue)
    ])
  end

  it "renders a list of venues" do
    render
    
    assert_select ".venue", count: 2
    assert_select '.venue img', count: 2

    expect(rendered).to include(@venues[0].name)
    expect(rendered).to include(@venues[0].about)
  end
end
