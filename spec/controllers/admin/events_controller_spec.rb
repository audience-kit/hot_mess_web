require 'rails_helper'

RSpec.describe Admin::EventsController, :type => :controller do
  include_context 'session'
  it_behaves_like :admin_page

  let(:valid_attributes) {
    attributes_for(:event)
  }

  let(:invalid_attributes) {
    { name: nil }
  }
  describe "GET new" do
    it "assigns a new event as @event" do
      get :new, {}, valid_admin_session
      expect(assigns(:event)).to be_a_new(Event)
    end
  end



  describe "GET edit" do
    it "assigns the requested event as @event" do
      event = create(:event)
      get :edit, {:id => event.to_param}, valid_admin_session
      expect(assigns(:event)).to eq(event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}, valid_admin_session
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, {:event => valid_attributes}, valid_admin_session
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it "redirects to the created event" do
        post :create, {:event => valid_attributes}, valid_admin_session

        expect(response).to redirect_to(Event.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        post :create, {:event => invalid_attributes}, valid_admin_session
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, {:event => invalid_attributes}, valid_admin_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { name: 'Some new name' }
      }

      it "updates the requested event" do
        event = create(:event)
        put :update, {:id => event.to_param, :event => new_attributes}, valid_admin_session
        event = Event.find(event.id)
        expect(event.name).to eq('Some new name')
      end

      it "assigns the requested event as @event" do
        event = create(:event)
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_admin_session
        expect(assigns(:event)).to eq(event)
      end

      it "redirects to the event" do
        event = create(:event)
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_admin_session
        expect(response).to redirect_to(event)
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        event = create(:event)
        put :update, {:id => event.to_param, :event => invalid_attributes}, valid_admin_session
        expect(assigns(:event)).to eq(event)
      end

      it "re-renders the 'edit' template" do
        event = create(:event)
        put :update, {:id => event.to_param, :event => invalid_attributes}, valid_admin_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      event = create(:event)
      expect {
        delete :destroy, {:id => event.to_param}, valid_admin_session
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = create(:event)
      delete :destroy, {:id => event.to_param}, valid_admin_session
      expect(response).to redirect_to(events_url)
    end
  end
end
