class ShippingOption < ActiveRecord::Base
	  establish_connection :haonzhao
	  attr_accessible :option_value, :shipping_id, :price
	  self.table_name = 'oc_shopping_option'
end
