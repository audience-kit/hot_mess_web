require 'rails_helper'

RSpec.describe "Venues", :type => :request do
  include_context 'session'

  let (:user) {
    create(:user)
  }

  let (:api_token) {
    user_id = user.to_param
    user_token = crypt.encrypt_and_sign user_id
    ActionController::HttpAuthentication::Token.encode_credentials user_token
  }

  let (:crypt) {
    ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
  }

  describe "GET /venues" do
    it "works for HTML with valid session" do
      get venues_path, nil, { 'X-Test-User' => valid_user_session[:user_id]}
      expect(response.status).to be(200)
    end

    it "works for API access with JSON format" do
      get venues_path(format: :json), nil, { 'HTTP_AUTHORIZATION' => api_token }
      expect(response.status).to be(200)
    end
  end
end
