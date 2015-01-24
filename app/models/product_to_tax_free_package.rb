class ProductToTaxFreePackage < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :package_id, :product_id,:quantity
end
