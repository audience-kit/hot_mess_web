class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    logger.debug "\tFacebook login with status #{facebook_session_params[:status]}"

    if facebook_session_params[:status] == 'connected'
      #auth_response = Facebook.signed_message(facebook_session_params[:authResponse][:signedRequest])
      #logger.debug "\tReceived Facebook signed authentication message #{auth_response.inspect}"

      #access_token_info = Facebook.oauth.get_access_token_info(auth_response['code'])
      #logger.debug "\tGot access token info from Facebook #{access_token_info.inspect}"

      session[:facebook_access_token] = params[:authResponse][:accessToken]
      session[:facebook_access_expires] = params[:authResponse][:expiresIn].to_i

      token_connection = Faraday.new url: Rails.application.secrets.api_location, ssl: { verify: false }

      response = token_connection.post '/token', facebook_token: session[:facebook_access_token], device: { type: 'web', identifier: request.remote_ip }

      if response.status == 200
        session[:session_valid] = true

        # redirect_to facebook_session_params[:redirect_to]
        return render text: 'OK', status: 200
      end
    end

    render :status => 500
  end

  def token
    params.require(:facebook_auth_token)

    @user = User.find_by_facebook_token params[:facebook_auth_token]
    
    response_object = { auth_token: Rails.application.crypt.encrypt_and_sign(@user.to_param),
                        user_id: @user.to_param }

    render json: response_object
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
