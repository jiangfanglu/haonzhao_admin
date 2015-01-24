class Supplier < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :shop_id, :name,:identification,:address,:country_code,:contact,:contact_no,:email,:website,:wechat,:qq,:grade
	belongs_to :hz_country
end
