module Facebook
  def self.oauth
    facebook_secrets = Rails.application.secrets['facebook']
    @facebook_oauth ||= Koala::Facebook::OAuth.new(facebook_secrets['app_id'], facebook_secrets['secret'])
  end

  def self.application_graph
    @facebook_app_access_token ||= oauth.get_app_access_token
    logger.debug "\tFacebook App Access Token => #{@facebook_app_access_token}"
    @facebook_graph = Koala::Facebook::API.new(@facebook_app_access_token)
  end
  
  def self.signed_message(request)
    oauth.parse_signed_request request
  end
end