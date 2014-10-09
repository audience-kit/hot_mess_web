class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_filter :set_user
  before_filter :ignore_newrelic

  def json_request?
    request.format.json?
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
      session[:first_name]  = user.first_name
      session[:last_name]   = user.last_name
      session[:name]        = user.person.name
      session[:person_id]   = user.person.id.to_s

      @user = user
      return
    end

    case request.format
      when Mime::XML, Mime::JSON
        user = authenticate_with_http_token do |token, _|
          decoded_user_id = Rails.application.crypt.decrypt_and_verify(token)
          User.find(decoded_user_id)
        end

        if user
          @user = user
        else
          request_http_token_authentication
        end
      else
        if session[:user_id].nil?
          redirect_to root_path and return false
        else
          logger.debug "\tSession User ID => #{session[:user_id].inspect}"
          @user ||= User.find(BSON::ObjectId.from_string(session[:user_id]))
        end
    end
  end

  def ignore_newrelic
    NewRelic::Agent.ignore_transaction if request.user_agent and request.user_agent.include? 'NewRelicPinger'
  end
end
