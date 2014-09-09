require 'rails_helper'

RSpec.describe Admin::LocalesController, :type => :controller do
  include_context 'session'
  it_behaves_like :admin_page

  describe "GET index" do
    it "assigns a list of locales" do
      get :index, {}, valid_admin_session
      expect(assigns[:locales]).to_not be nil
    end

    it "renders the index view" do
      get :index, {}, valid_admin_session
      expect(response).to render_template 'index'
    end
  end

  describe "GET new" do
    it "assigns a new event to @locale" do
      get :new, {}, valid_admin_session
      expect(assigns[:locale]).to_not be nil
    end

    it "renders the new view" do
      get :new, {}, valid_admin_session
      expect(response).to render_template 'new'
    end
  end
end
