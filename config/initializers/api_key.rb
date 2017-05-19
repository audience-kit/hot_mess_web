API_CONNECTION = Faraday.new(:url => 'https://api.hotmess.social') do |faraday|
  faraday.response :logger

  faraday.authorization('Bearer', Rails.application.secrets[:api_key])
  faraday.response :json, :content_type => 'application/json'
  faraday.request :json

  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end