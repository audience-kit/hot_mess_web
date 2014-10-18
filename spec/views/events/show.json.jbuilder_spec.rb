require 'rails_helper'

RSpec.describe 'events/show.json.jbuilder', type: :view do
  before(:each) do
    @event = assign(:event, create(:event))
  end

  it 'should render an event' do
    render

    result = JSON.parse(rendered)
    expect(result['id']).to eq(@event.id.to_s)
    expect(result['picture']['url']).to_not be_nil
  end
end