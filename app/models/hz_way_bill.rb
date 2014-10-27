class HzWayBill < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :out_state,:out_time,:way_bill_no,:order_id
	belongs_to :order, :primary_key=>"order_id", :foreign_key=>"order_id"
	belongs_to :hz_order, :primary_key=>"order_id", :foreign_key=>"order_id"
end
