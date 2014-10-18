require 'rails_helper'

RSpec.describe 'events/index.json.jbuilder', type: :view do
  before(:each) do
    @events = assign(:event, [ create(:event), create(:event) ])
  end

  it 'should render a list of events' do
    render

    result = JSON.parse(rendered)

    expect(result.count).to eq(2)
    expect(result[0]['id']).to eq(@events[0].id.to_s)
    expect(result[0]['name']).to eq(@events[0].name)
    expect(result[0]['picture_url']).to_not be_nil
  end
end
