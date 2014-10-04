class OrderTotal < ActiveRecord::Base
	establish_connection :haonzhao
  	self.table_name = :oc_order_total
  	belongs_to :order
end
