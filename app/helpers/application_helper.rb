module ApplicationHelper
  def is_admin?
    if session[:user_id]
      @user.is_admin
    else
      false
    end
  end
  
  def picture_for(model, size = :normal)
    render partial: 'shared/picture', locals: { object: model, size: size }
  end
end
