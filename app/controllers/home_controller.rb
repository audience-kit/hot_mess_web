class HomeController < ApplicationController
  layout 'cover', except: :dashboard
  skip_before_action :set_user, except: :dashboard

  # GET /homes
  # GET /homes.json
  def index
    redirect_to dashboard_path if session[:user_id]
  end

  def dashboard
    @venues = Venue.all
  end

  def privacy
  end
end
