class CustomCategory < ActiveRecord::Base
	establish_connection :haonzhao
  attr_accessible :category_id
  belongs_to :category
  
end
