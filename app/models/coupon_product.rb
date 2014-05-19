class CouponProduct < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :coupon_id,:product_id
	self.table_name = 'oc_coupon_product'
     self.primary_key = 'coupon_product_id'
end
