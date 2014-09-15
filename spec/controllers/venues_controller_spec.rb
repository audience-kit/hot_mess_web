require 'rails_helper'

RSpec.describe VenuesController, :type => :controller do
  include_context 'session'

  describe "GET index" do
    it "assigns all venues as @venues" do
      venue = create(:venue)
      get :index, {}, valid_user_session
      expect(assigns(:venues)).to include(venue)
    end

    it "should allow json pull with authorization token" do
      auth_token = 'cG5oTVBUd21qcFFUUjBhWUYxNzhWcTJZbWthdVZDQzhtZ3NRMThFUlV4MUpJRWNCbkg3MTFOc0lTcUhOaWNoSC0tRWxPNzFkNnVKSDN5VWV1MTBZM1o5Zz09--12e02e6d61fb9b57d52cff32f6274873daf55279'
      venue = create(:venue)

      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(auth_token)
      get :index, { format: :json }

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
