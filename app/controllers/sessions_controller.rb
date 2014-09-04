class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    logger.debug "\tFacebook login with status #{facebook_session_params[:status]}"

    if facebook_session_params[:status] == 'connected'
      auth_response = facebook_signed_message(facebook_session_params[:authResponse][:signedRequest])
      logger.debug "\tReceived Facebook signed authentication message #{auth_response.inspect}"

      user_id = facebook_session_params[:authResponse][:userID].to_i
      user = User.includes(:person).find_or_initialize_by(facebook_id: user_id)

      access_token_info = facebook_oauth.get_access_token_info(auth_response['code'])
      logger.debug "\tGot access token info from Facebook #{access_token_info.inspect}"

      session[:facebook_access_token] = access_token_info['access_token']
      session[:facebook_access_expires] = access_token_info['expires'].to_i

      long_access_token = facebook_oauth.exchange_access_token_info(access_token_info['access_token'])

      user.facebook_access_token = long_access_token['access_token']
      user.facebook_expires_in = long_access_token['expires'].to_i

      user.update_from_facebook

      user.save

      session[:user_id]     = user.id.to_s
      session[:is_admin]    = user.is_admin
      session[:first_name]  = user.person.first_name
      session[:last_name]   = user.person.last_name
      session[:name]        = user.person.name
      session[:person_id]   = user.person.id.to_s

      # redirect_to facebook_session_params[:redirect_to]
      render nothing: true, status: 200
    else
      render :status => 500
    end
  end

  def destroy
    session.clear

    render nothing: true, status: 200
  end

  private
  def facebook_session_params
    params.permit!
  end
end
