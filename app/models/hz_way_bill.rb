class HzWayBill < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :pg_result, :pg_comment, :pg_time, :out_state,:out_time,:way_bill_no,:order_id,:ie_port, :custom_field, :tranf_mode, :destination_port, :decl_port, :entering_person, :sender_city, :logistic_company_code, :logistic_company_name, :post_mode, :sender_country, :sender_name, :personal_goods_form_no, :tax_amount, :is_tax_needed
	belongs_to :order, :primary_key=>"order_id", :foreign_key=>"order_id"
	belongs_to :hz_order, :primary_key=>"order_id", :foreign_key=>"order_id"
end
