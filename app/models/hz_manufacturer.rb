class HzManufacturer < ActiveRecord::Base
	establish_connection :haonzhao
	belongs_to :shop,:primary_key=>"manufacturer_id", :foreign_key=>"manufacturer_id"
	belongs_to :hz_country, :foreign_key=>"hz_country_code",:primary_key=>"code"
end
