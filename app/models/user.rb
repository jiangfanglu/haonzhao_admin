#encoding: utf-8
class User < ActiveRecord::Base
  self.table_name = 'z2act_users'
  
  #attr_accessible :name, :email, :id
  
  validates :name, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true
  validates :email, :uniqueness=>true

  has_many :sender_messages, foreign_key: 'user_id_from', primary_key: 'id', class_name: 'Message'
  has_many :receiver_messages, foreign_key: 'user_id_to', primary_key: 'id', class_name: 'Message'
  
  has_one :shop, foreign_key: 'manufacturer_id', class_name: 'Shop'
  has_one :customer, foreign_key: 'user_id', class_name: 'Customer'
  has_many :comments, foreign_key: 'user_id', class_name: 'Comment'
  has_many :posts, foreign_key: 'sender_id', class_name: 'Post'
  has_many :products, foreign_key: 'manufacturer_id'
  has_many :artworks, foreign_key: 'user_id', class_name: 'Artwork'
  has_many :fans, foreign_key: 'artist_user_id', class_name: 'Follower'
  has_many :idols, foreign_key: 'follower_user_id', class_name: 'Follower'
  has_many :collections, foreign_key: 'user_id', class_name: 'Collection'
  has_many :orders, foreign_key: 'email', primary_key: 'email', class_name: 'Order'
  has_many :seller_orders, foreign_key: 'store_id', primary_key: 'id', class_name: 'Order'
  has_many :published, foreign_key: 'user_id', class_name: 'Published'
  # has_many :products, :through => :published
  has_many :userlists
  belongs_to :custom_order_request
  has_many :custom_order_requests, :primary_key => "id", :foreign_key => "manufacturer_id", :class_name => "CustomOrderRequest"
  has_one :seller_payment
  has_many :transactions, foreign_key: 'store_id'
  
  has_many :receivables_list, foreign_key: 'receiver_id', class_name: 'Transaction', as: :receiver
  
  has_many :pay_list, foreign_key: 'sender_id', class_name: 'Transaction', as: :sender
  
  
  def set_token
    self.token = Digest::SHA2.hexdigest "#{username}-#{lastvisitDate.to_i}"
  end
  
  def shop_user?
    usertype.to_i == 1
  end
    
end
