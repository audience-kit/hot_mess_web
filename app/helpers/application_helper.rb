module ApplicationHelper
  def is_admin?
    @user.is_admin
  end
end
