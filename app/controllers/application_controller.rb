class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :splash

  def splash
    if session[:session_valid] and params[:controller] != 'home'
      render 'home/beta', layout: 'cover'
    end
  end
end
