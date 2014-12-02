class Page < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :alias, :content, :path
end
