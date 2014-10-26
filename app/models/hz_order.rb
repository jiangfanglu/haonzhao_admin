class HzOrder < ActiveRecord::Base
	establish_connection :haonzhao
	belongs_to :order, :primary_key=>"order_id", :foreign_key=>"order_id"
	has_many :hz_way_bills, :primary_key=>"order_id", :foreign_key=>"order_id"
end
