class Admin < ActiveRecord::Base

  attr_accessible :name, :email, :id, :salt, :password, :token, :usertype, :params, :activation, :username


  self.table_name = 'admins'
  
  
end
