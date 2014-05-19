class ProfileGroup < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :name,:alias
	self.table_name = 'profile_groups'
end
