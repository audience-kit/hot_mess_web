require 'rails_helper'

RSpec.describe "venues/index.json.jbuilder", type: :view do
  before(:each) do
    @venues = assign(:venues, [
        create(:venue),
        create(:venue)
    ])
  end

  it "renders a list of venues" do
    render
    
    result = JSON.parse(rendered)
    
    expect(result.count).to be 2
    expect(result[0]['url']).to_not be_nil
    expect(result[0]['name']).to eq @venues[0].name
  end
end
