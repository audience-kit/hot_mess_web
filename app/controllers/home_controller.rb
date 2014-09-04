class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :facebook_config

  # GET /homes
  # GET /homes.json
  def index
    respond_to do |format|
      format.html
    end
  end

  def facebook_config
    @facebook_app_id = Rails.application.secrets['facebook']['app_id']
  end
end
