class HzProduct < ActiveRecord::Base
	establish_connection :haonzhao
	belongs_to :product
end
