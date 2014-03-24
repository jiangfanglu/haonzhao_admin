class Service < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :name, :service_category, :fee
  belongs_to :service_category
  belongs_to :fee
  
  has_many :shop_and_services
  has_many :shops, through: :shop_and_services
  
  
end
