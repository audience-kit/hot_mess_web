class Admin::AdminController < ApplicationController
  before_action :check_admin_access

  private
  def check_admin_access
    redirect_to dashboard_path unless session[:is_admin]
  end
end