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
  end

  def about
  end
end
