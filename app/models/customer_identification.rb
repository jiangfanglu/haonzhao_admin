class CustomerIdentification < ActiveRecord::Base
	establish_connection :haonzhao
	belongs_to :user
end
