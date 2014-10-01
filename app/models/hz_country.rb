class HzCountry < ActiveRecord::Base
	establish_connection :haonzhao
	has_many :hz_manufacturers, :primary_key=>"code", :foreign_key=>"hz_country_code"
end
