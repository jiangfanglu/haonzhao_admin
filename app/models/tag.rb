class Tag < ActiveRecord::Base
  attr_accessible :id, :created_at, :updated_at, :name, :taggable_id, :taggable_type
  # self.table_name = 'z2act_tags'
  establish_connection :haonzhao
  validates_uniqueness_of :name, :scope => [:taggable_id, :taggable_type]
  belongs_to :taggable, polymorphic: true 
end
