class Transaction < ActiveRecord::Base
  
  belongs_to :shop, foreign_key: 'store_id'
  
end
