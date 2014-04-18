class Settlement < ActiveRecord::Base
  attr_accessible :comment, :title
  
  has_many :transactions
  belongs_to :shop
end
