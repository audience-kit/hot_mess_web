require 'rails_helper'

RSpec.describe VenuesController, :type => :controller do
  include_context 'session'

  let (:api_token) {
    user_token = crypt.encrypt_and_sign valid_user_session[:user_id]
    ActionController::HttpAuthentication::Token.encode_credentials user_token
  }

  let (:crypt) {
    ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
  }

  describe "GET index" do
    it "assigns all venues as @venues" do
      venue = create(:venue)
      get :index, {}, valid_user_session
      expect(assigns(:venues)).to include(venue)
    end

    it "should allow json pull with authorization token" do
      venue = create(:venue)

      request.env['HTTP_AUTHORIZATION'] = api_token
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
