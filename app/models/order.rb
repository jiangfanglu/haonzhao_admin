#encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :order_count, :total, :order_status_id, :shipping_option_id, :user_agent, :ip, :payment_sn,:order_sn, :shipping_code, :shipping_method
  self.table_name = 'oc_order'
  
end
