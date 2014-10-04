class HzManufacturer < ActiveRecord::Base
	establish_connection :haonzhao
	self.primary_key = :manufacturer_id
	belongs_to :shop,:primary_key=>"manufacturer_id", :foreign_key=>"manufacturer_id",:class_name=>"Shop"
	belongs_to :hz_country, :foreign_key=>"hz_country_code",:primary_key=>"code"
end
