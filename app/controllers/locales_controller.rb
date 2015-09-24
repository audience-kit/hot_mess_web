class LocalesController < ApplicationController
  def show
    session[:locale] = params[:id]

    redirect_to dashboard_path
  end
end
