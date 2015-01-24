class TaxFreePackage < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :description, :name, :purchase_count, :viewed,:supplier_id,:meta_desctiption
end
