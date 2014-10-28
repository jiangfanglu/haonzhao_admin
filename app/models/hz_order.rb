class HzOrder < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :post_mode, :approve_result,:approve_comment,:process_time,:ie_port,:customs_field,:tranf_mode,:destination_port,:sender_name, :sender_country, :decl_port,:entering_person,:sender_city,:pg_result,:pg_comment,:pg_time,:personal_goods_form_no,:pg_approve_result,:pg_approve_comment,:pg_approve_time,:tax_amount,:is_tax_needed
	belongs_to :order, :primary_key=>"order_id", :foreign_key=>"order_id"
	has_many :hz_way_bills, :primary_key=>"order_id", :foreign_key=>"order_id"
end
