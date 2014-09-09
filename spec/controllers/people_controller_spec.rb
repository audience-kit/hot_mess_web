require 'rails_helper'

RSpec.describe PeopleController, :type => :controller do
  include_context 'session'

  describe "GET index" do
    it "returns http success" do
      get :index, {}, valid_user_session
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "returns http success" do
      person = create(:person)
      get :show, { id: person.id }, valid_user_session
      expect(response).to be_success
    end
  end


end
