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
    client = Twilio::REST::Client.new 'AC5f75bb86a003e5cda83d9d7514de864b', Rails.application.secrets[:twilio_key]

    client.messages.create(
        from: '+14063154776',
        to: '+14067881551',
        body: session[:me].inspect
    )
  end

  def about
  end

  def apple_association
    send_file Rails.root.join('config/site_association.json'), content_type: 'application/json'
  end
end
