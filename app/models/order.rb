#encoding: utf-8
class Order < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :invoice_no, :invoice_prefix, :store_id, :store_name, :store_url, :customer_id, :customer_group_id, :firstname, :lastname, :email, :telephone, :fax, :payment_firstname, :payment_lastname, :payment_company, :payment_company_id, :payment_tax_id, :payment_address_1, :payment_address_2, :payment_city, :payment_postcode, :payment_country, :payment_country_id, :payment_zone, :payment_zone_id, :payment_address_format, :payment_method, :payment_code, :shipping_firstname, :shipping_lastname, :shipping_company, :shipping_address_1, :shipping_address_2, :shipping_city, :shipping_postcode, :shipping_country, :shipping_country_id, :shipping_zone, :shipping_zone_id, :shipping_address_format, :shipping_method, :shipping_code, :comment, :total, :order_status_id, :affiliate_id, :commission, :language_id, :currency_id, :currency_code, :currency_value, :ip, :forwarded_ip, :user_agent, :accept_language, :date_added, :date_modified, :shipping_option_id, :address_id, :order_sn, :payment_sn
  self.table_name = :oc_order
  self.primary_key = :order_id
  belongs_to :shop, foreign_key: :store_id, :primary_key=>"manufacturer_id"
  belongs_to :order_status
  has_many :order_totals

  has_many :order_products
  belongs_to :customer,:primary_key=>"customer_id", :foreign_key=>"customer_id"

  has_one :hz_order, :primary_key=>"order_id", :foreign_key=>"order_id"
  has_many :hz_order_returns, :primary_key=>"order_id", :foreign_key=>"order_id"
  has_many :hz_way_bills, :primary_key=>"order_id", :foreign_key=>"order_id"
  
  def restore
    
  end
  
  def cancel
    self.order_status = OrderStatus.where(name: 'Canceled').first and save
  end
  
  def write_order_history operation_name, operator, uid
    OrderHistory.create(operation: Operation.find_by_name(operation_name), order_id: self.order_id, order_status_id: self.order_status_id, operator_role: operator, operator_id: uid)
  end
end
