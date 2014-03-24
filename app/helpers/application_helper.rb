module ApplicationHelper
  
  def current_user
    @current_user ||= Admin.find_by_id(session[:user]) || false
  end
  
  def authenticate(user,password_to_confirm)
    return user.password.to_s == Digest::SHA2.hexdigest(user.salt + password_to_confirm).to_s
  end
  
  
end
