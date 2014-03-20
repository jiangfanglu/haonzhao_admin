class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :aliyunoss_authenticate
  
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
  
end
