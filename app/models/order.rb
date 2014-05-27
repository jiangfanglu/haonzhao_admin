#encoding: utf-8
class Order < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :invoice_no, :invoice_prefix, :store_id, :store_name, :store_url, :customer_id, :customer_group_id, :firstname, :lastname, :email, :telephone, :fax, :payment_firstname, :payment_lastname, :payment_company, :payment_company_id, :payment_tax_id, :payment_address_1, :payment_address_2, :payment_city, :payment_postcode, :payment_country, :payment_country_id, :payment_zone, :payment_zone_id, :payment_address_format, :payment_method, :payment_code, :shipping_firstname, :shipping_lastname, :shipping_company, :shipping_address_1, :shipping_address_2, :shipping_city, :shipping_postcode, :shipping_country, :shipping_country_id, :shipping_zone, :shipping_zone_id, :shipping_address_format, :shipping_method, :shipping_code, :comment, :total, :order_status_id, :affiliate_id, :commission, :language_id, :currency_id, :currency_code, :currency_value, :ip, :forwarded_ip, :user_agent, :accept_language, :date_added, :date_modified, :shipping_option_id, :address_id, :order_sn, :payment_sn
  self.table_name = :oc_order
  self.primary_key = :order_id
  belongs_to :shop, foreign_key: :store_id
  belongs_to :order_status
  
  def restore
    
  end
  
  def cancel
    self.order_status = OrderStatus.where(name: 'Canceled').first and save
  end
  
end
