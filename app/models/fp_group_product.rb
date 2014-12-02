class FpGroupProduct < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :group_id, :product_id

	belongs_to :product
	belongs_to :categorynavgroup,:foreign_key=>"group_id",:primary_key=>"id", :class_name=>"Categorynavgroup"
end
