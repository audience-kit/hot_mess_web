shared_examples :admin_page do
  context 'GET index' do
    it "redirects non-admin users" do
      get :index, {}, valid_user_session
      expect(response).to_not render_template 'new'
      expect(response).to redirect_to dashboard_path
    end

    it "redirects when not logged in" do
      get :index
      expect(response).to_not render_template 'new'
      expect(response).to redirect_to root_path
    end
  end

  context 'GET new' do
    it "redirects non-admin users" do
      get :new, {}, valid_user_session
      expect(response).to_not render_template 'new'
      expect(response).to redirect_to dashboard_path
    end

    it "redirects when not logged in" do
      get :new
      expect(response).to_not render_template 'new'
      expect(response).to redirect_to root_path
    end
  end
end