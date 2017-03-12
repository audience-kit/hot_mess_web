class HomeController < ApplicationController
  layout 'cover', except: :dashboard

  # GET /homes
  # GET /homes.json
  def index
    redirect_to action: :beta if session[:session_valid]
  end

  def privacy
  end

  def contact
  end

  def beta
    client = Twilio.connect 'AC5f75bb86a003e5cda83d9d7514de864b', Rails.application.secrets[:twilio_key]

    Twilio::Sms.message('+14063154776','+14067881551', session[:me].inspect)
  end

  def about
  end
end
