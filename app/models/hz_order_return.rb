class HzOrderReturn < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :app_code, :customs_field, :decl_port, :return_way_bill_no, :original_way_bill_no, :pack_no, :pack_type, :return_product_ids, :decl_time
	belongs_to :order, :primary_key=>"order_id", :foreign_key=>"order_id"
end
