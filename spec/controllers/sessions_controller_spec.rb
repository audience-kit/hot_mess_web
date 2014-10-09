require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  context "mobile login" do
    it 'should return an authorization token for a valid facebook token' do
      Mock::Facebook.mock_facebook_api(self)
      
      params = { state: 'mobile_connected',
                 facebook_auth_token: 'some_facebook_token'}

      post :token, params

      response_object = JSON.parse(response.body)

      expect(response_object['auth_token']).to_not be_nil
      expect(response_object['user_id']).to_not be_nil
    end
  end
end
