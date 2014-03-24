class ServiceCategory < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :name
  has_many :services
end
