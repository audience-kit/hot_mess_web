class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :facebook_config
  skip_before_action :set_user, only: [ :index, :facebook_config, :privacy ]

  # GET /homes
  # GET /homes.json
  def index
    logger.debug "\tSession => #{session.inspect}"
    respond_to do |format|
      format.html do
        if session[:user_id]
          redirect_to dashboard_path
        else
          render layout: false
        end
      end
    end
  end

  def dashboard
    @venues = Venue.all

    respond_to do |format|
      format.html
    end
  end

  def privacy
  end

  def facebook_config
    @facebook_app_id = Rails.application.secrets['facebook']['app_id']
  end
end
