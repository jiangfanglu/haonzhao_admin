class ServiceCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :services
end
