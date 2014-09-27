class HzManufacturer < ActiveRecord::Base
	establish_connection :haonzhao
	belongs_to :shop
end
