require 'rails_helper'

RSpec.describe "Venues", :type => :request do
  include_context 'session'

  describe "GET /venues" do
    it "works! (now write some real specs)" do
      get venues_path, {}, valid_user_session
      expect(response.status).to be(200)
    end
  end
end
