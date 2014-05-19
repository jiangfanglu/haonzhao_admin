class Profile < ActiveRecord::Base
	  establish_connection :haonzhao
	  attr_accessible :name,:alias, :profile_type, :profile_group_id
	  self.table_name = 'profiles'
end
