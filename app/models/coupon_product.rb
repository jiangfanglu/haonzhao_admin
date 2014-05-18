class CouponProduct < ActiveRecord::Base
	establish_connection :haonzhao
	self.table_name = 'oc_coupon_product'
     self.primary_key = 'coupon_product_id'
end
