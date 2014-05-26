class Shipping < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :name, :code
	self.table_name = 'oc_shipping'
end
