require 'rails_helper'

RSpec.describe "Venues", :type => :request do
  include_context 'session'

  describe "GET /venues" do
    it "works! (now write some real specs)" do
      get venues_path, nil, { 'X-Test-User' => valid_user_session[:user_id]}
      expect(response.status).to be(200)
    end
  end
end
