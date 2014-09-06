module ApplicationHelper
  def is_admin?
    if session[:user_id]
      @user.is_admin
    else
      false
    end
  end
end
