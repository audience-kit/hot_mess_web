class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_user

  def facebook_signed_message(request)
    facebook_oauth.parse_signed_request request
  end

  def facebook_oauth
    facebook_secrets = Rails.application.secrets['facebook']
    @facebook_oauth ||= Koala::Facebook::OAuth.new(facebook_secrets['app_id'], facebook_secrets['secret'])
  end

  def facebook_graph
    @@facebook_app_access_token ||= facebook_oauth.get_app_access_token
    logger.debug "\tFacebook App Access Token => #{@@facebook_app_access_token}"
    @facebook_graph = Koala::Facebook::API.new(@@facebook_app_access_token)
  end

  def user
    @user
  end

  private
  def set_user
    if Rails.env == 'test' && env['HTTP_X_TEST_USER']
      logger.debug "\tSetting up test user #{env['HTTP_X_TEST_USER']}"
      user = User.find(env['HTTP_X_TEST_USER'])

      session[:user_id]     = user.id.to_s
      session[:is_admin]    = user.is_admin
      session[:first_name]  = user.person.first_name
      session[:last_name]   = user.person.last_name
      session[:name]        = user.person.name
      session[:person_id]   = user.person.id.to_s

      @user = user
      return
    end


    if session[:user_id].nil?
      redirect_to root_path
    else
      logger.debug "\tSession User ID => #{session[:user_id].inspect}"
      @user ||= User.find(BSON::ObjectId.from_string(session[:user_id]))
    end
  end
end
