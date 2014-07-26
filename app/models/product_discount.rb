class ProductDiscount < ActiveRecord::Base
	  establish_connection :haonzhao
	  attr_accessible :product_id, :customer_group_id, :quantity, :priority, :price, :date_start, :date_end
	  self.table_name = :oc_product_discount
	  self.primary_key = :product_discount_id
	  
	  belongs_to :product

	  def save_info(product_id,customer_group_id,quantity,priority,price,date_start,date_end)
	    self.product_id = product_id
	    self.customer_group_id = customer_group_id
	    self.quantity = quantity
	    self.priority = priority
	    self.price = price
	    self.date_start = date_start
	    self.date_end = date_end
	  end
end
