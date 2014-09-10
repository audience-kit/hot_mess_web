require 'rails_helper'

RSpec.describe "venues/show", :type => :view do
  before(:each) do
    @venue = assign(:venue, create(:venue))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to include(@venue.name)
    expect(rendered).to include(@venue.description)
  end
end
