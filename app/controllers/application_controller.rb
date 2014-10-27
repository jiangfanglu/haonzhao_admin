class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :aliyunoss_authenticate, :login?
  
  helper_method :current_user
  
  #require "aliyun-oss"

  # require 'active_support/all'
  # require 'digest/md5'
  def aliyunoss_authenticate
    Aliyun::OSS::Base.establish_connection!(
       :access_key_id     => ALIYUNOSS_ACCESS_KEY_ID, 
       :secret_access_key => ALIYUNOSS_SECRET_ACCESS_KEY
    )
    # Aliyun::OSS::Base.establish_connection!(
    #   :access_key_id     => "tZu94MC4MJVTEuvj", 
    #   :secret_access_key => "e8iglZEc1rKeIv3KbepxnvftGoY7Q7"
    # )
  end
  
  def login?
    return redirect_to controller: :shops, action: :login unless current_user || params[:action] == "hz_record_result"
  end
  
  def current_user
    @current_user ||= Admin.find_by_id(session[:user]) || false
  end
  
  def authenticate(user,password_to_confirm)
    return user.password.to_s == Digest::SHA2.hexdigest(user.salt + password_to_confirm).to_s
  end
  
end
