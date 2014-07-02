class ShippingOption < ActiveRecord::Base
	  establish_connection :haonzhao
	  attr_accessible :option_value, :shipping_id, :price
	  self.table_name = 'oc_shipping_option'
end
