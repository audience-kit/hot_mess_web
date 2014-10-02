shared_context 'session' do
  before(:each) do
    @user = create(:user)
    @admin = create(:admin)
  end

  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
        name: "Seattle"
    }
  }

  let(:invalid_attributes) {
    {
        name: nil
    }
  }

  # This should return the minimal set of values that should be in the sessions
  # in order to pass any filters (e.g. authentication) defined in
  # EventsController. Be sure to keep this updated too.
  let(:valid_admin_session) {
    {
        user_id: @admin.id,
        is_admin: true
    }
  }

  let(:valid_user_session) {
    {
        user_id: @user.id,
        is_admin: false
    }
  }
end
