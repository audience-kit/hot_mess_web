require 'rails_helper'

RSpec.describe VenuesController, :type => :controller do
  include_context 'session'

  describe "GET index" do
    it "assigns all venues as @venues" do
      venue = create(:venue)
      get :index, {}, valid_user_session
      expect(assigns(:venues)).to include(venue)
    end
  end

  describe "GET show" do
    it "assigns the requested venue as @venue" do
      venue = create(:venue)
      get :show, {:id => venue.to_param}, valid_user_session
      expect(assigns(:venue)).to eq(venue)
    end
  end
end
