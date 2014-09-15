require 'rails_helper'

RSpec.describe "Venues", :type => :request do
  include_context 'session'

  let (:api_token) {
    ActionController::HttpAuthentication::Token.encode_credentials('cG5oTVBUd21qcFFUUjBhWUYxNzhWcTJZbWthdVZDQzhtZ3NRMThFUlV4MUpJRWNCbkg3MTFOc0lTcUhOaWNoSC0tRWxPNzFkNnVKSDN5VWV1MTBZM1o5Zz09--12e02e6d61fb9b57d52cff32f6274873daf55279')
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
