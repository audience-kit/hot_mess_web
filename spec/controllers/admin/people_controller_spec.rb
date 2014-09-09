require 'rails_helper'

RSpec.describe Admin::PeopleController, :type => :controller do
  include_context 'session'
  it_behaves_like :admin_page

  describe "GET new" do
    it "returns http success" do
      get :new, {}, valid_admin_session
      expect(response).to be_success
    end
  end

  describe "GET edit" do
    it "returns http success" do
      person = create(:person)
      get :edit, { id: person.id }, valid_admin_session
      expect(response).to be_success
    end
  end

  describe "GET destroy" do
    it "returns http success" do
      person = create(:person)
      delete :destroy, { id: person.id }, valid_admin_session
      expect(response).to be_success
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, {}, valid_admin_session
      expect(response).to be_success
    end

    it "renders the new view" do
      get :new, {}, valid_admin_session
      expect(response).to render_template 'new'
    end

    it "assigns a new person object" do
      get :new, {}, valid_admin_session
      expect(assigns[:person]).to be_a_new(Person)
    end

  end

end
