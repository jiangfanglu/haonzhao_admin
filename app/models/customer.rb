require 'application_helper'
class Customer < ActiveRecord::Base
  establish_connection :haonzhao
  include ApplicationHelper
  attr_accessible :email, :firstname, :ip
  self.table_name = 'oc_customer'
  self.primary_key = 'customer_id'
  
  validate :address_id, :presence => true
  validate :email, :presence => true
  validate :password, :presence => true
  validate :firstname, :presence => true

  belongs_to :user
  has_many :addresses
  has_many :reviews, :primary_key => "customer_id", :foreign_key=>"customer_id"
  # has_one :state, foreign_key: 'zone_id', class_name: 'State', through: :address
  # has_one :city, foreign_key: 'city', class_name: 'City', through: :address
  # has_one :suburb, through: :address
  
  has_many :pay_list, foreign_key: 'sender_id', class_name: 'Transaction', as: :sender
  
  has_many :orders

  def initialize args={}
    super
    self.status = 0
    self.address_id = 0
    self.approved = 1
    self.customer_group_id = 1
  end
  
  def create_token
    self.token = gen_encrypt self.salt
  end
    
  
  def default_address
    (address_id.blank? || address_id == 0) ? nil : Address.where(address_id: address_id).first
  end

  def default_payment
    payment
  end
  
  def has_address?
    !address_id.blank?
  end
  
  def has_payment?
    !payment.blank?
  end

  def has_user?
    !user_id.blank?
  end
  
  def name
    firstname
  end
  
end
