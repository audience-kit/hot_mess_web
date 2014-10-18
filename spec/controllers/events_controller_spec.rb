require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  include_context 'session'


  let(:valid_attributes) {

  }

  let(:invalid_attributes) {

  }

  describe 'GET index' do
    it 'assigns all events as @events' do
      event = create(:event)
      get :index, {}, valid_user_session
      expect(assigns(:events)).to include event
    end

    it 'does not assign events in the past to @events' do
      event = create(:event)
      past_event = create(:past_event)
      get :index, {}, valid_user_session
      expect(assigns(:events)).to include event
    end
  end

  describe 'GET show' do
    it 'assigns the requested event as @event' do
      event = create(:event)
      get :show, {:id => event.to_param}, valid_user_session
      expect(assigns(:event)).to eq(event)
    end
  end

end
