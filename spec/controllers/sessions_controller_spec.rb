require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  context "mobile login" do
    it 'should return an authorization token for a valid facebook token' do
      params = { state: 'mobile_connected',
                 facebook_auth_token: 'CAAKI8px4npABAKA93g6tlawX77ZC8pIKcU6163SG7ZCV99ffMQ8GNBO8ZAUhQ9sIe6B0ImVnAcV8qgPXuJIJGtsMphNHZAjMTDL4n5op0L3iwETqrBemAZAV0vF9g5DQKZA7Lvpei9ONIELgV1F7jmWt2CRhAoc81qpiZBFhQwhxrJ5ZAjyPY8TFZAMMUINUkcMiz15IGJQUmW94XyQdSMSjwZCG1Lpa8AOZAsYGxZCH2e9jVQZDZD'}

      post :mobile_create, params

      response_object = JSON.parse(response.body)

      expect(response_object['auth_token']).to_not be_nil
      expect(response_object['user_id']).to_not be_nil
    end
  end
end
