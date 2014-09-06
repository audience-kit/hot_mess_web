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
    unless session[:user_id].nil?
      logger.debug "\tSession User ID => #{session[:user_id].inspect}"
      @user ||= User.find(BSON::ObjectId.from_string(session[:user_id]))
    end
  end
end
