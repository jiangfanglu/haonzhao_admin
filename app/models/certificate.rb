#encoding: utf-8
require 'code_lib'
class Certificate < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :code, :foo, :foo_type, :foo_id, :promotion_id, :customer_id
  KEY = '98531858825ll727'
  
  belongs_to :foo, polymorphic: true
  belongs_to :customer
  belongs_to :promotion
  
  class << self
    include CodeLib
  end

  def initialize args = {}
    super
    self.set_code
  end
  
  def set_code
    self.code = Certificate.create_code random
  end
  
  def random
    arr = ("a".."z").to_a + ("0".."9").to_a
    (0..11).map{ arr[rand(36)] }.join
  end
  
  def foo_for_select
    eval(self.foo_type).all
  end
  
end
