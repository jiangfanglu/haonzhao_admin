class OrderStatus < ActiveRecord::Base
  attr_accessible :name, :language_id, :order_status_id
  establish_connection :haonzhao
  self.table_name = :oc_order_status
  self.primary_key = :order_status_id
  default_scope conditions: "oc_order_status.language_id = 3"
  has_many :order
  # has_many :operations  
end
