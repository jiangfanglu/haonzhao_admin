class ProfileValue < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :name,:alias, :profile_id
	self.table_name = 'profile_values'
end
