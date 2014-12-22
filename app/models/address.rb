class Address < ActiveRecord::Base
	establish_connection :haonzhao
  	self.table_name = "oc_address"
  	self.primary_key = "address_id"
	  
	  validate :address_1, :presence => true
	  validate :customer_id, :presence => true
	  validate :city, :presence => true
	  validate :zone_id, :presence => true
	  validate :firstname, :presence => true

	  belongs_to :customer
	  has_one :country, :primary_key => "country_id", :foreign_key=>"country_id"
	  has_one :state, :primary_key => "zone_id", :foreign_key=>"provinceID"
	  has_one :cityy, :primary_key => "city", :foreign_key=>"cityID", :class_name => "City"
	  has_one :suburb, :primary_key => "district_id" , :foreign_key=>"areaID"

	  has_one :customer_identification, :primary_key => "address_id" , :foreign_key=>"address_id"
end
