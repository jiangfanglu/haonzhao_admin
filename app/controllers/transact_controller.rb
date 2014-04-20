class TransactController < ApplicationController
  before_action :set_shop, only: [:show, :paid_by_shop, :unpaid_by_shop]
  
  def index
    @shops = Shop.transact.paginate page: params[:page], per_page: 20
  end

  def show
    @transactions = Transaction.all_by_shop @shop.id
    render :_show
  end
  
  def paid_by_shop
    @transactions = Transaction.paid_by_shop @shop.id
    render :paid
  end

  def unpaid_by_shop
    @transactions = Transaction.unpaid_by_shop @shop.id
    render :unpaid
  end
  
  def create_settlement
    @settlement = Settlement.new(money_sign: 'CNY', money: 0)
    Transaction.where('id in (?) AND settlement_id is NULL AND status = "Settlement"', params[:ids].split('_')).each do|transaction|
      @settlement.transactions << transaction
      @settlement.money += transaction.money
      transaction.update_attribute(:status, 'Settlement')
    end
    @settlement.money = @settlement.transactions.collect{|t|t.money}.sum
    redirect_to action: :show_settlement, id: @settlement.id if !@settlement.transactions.blank? && @settlement.save
  end
  
  def show_settlement
    @settlement = Settlement.find params[:id]
    render :settlement
  end
  
  def update_settlement
    @settlement = Settlement.find params[:settlement][:id]
    @settlement.update_attributes(title: params[:settlement][:title], comment: params[:settlement][:comment])
    redirect_to action: :show_settlement, id: @settlement.id
  end
  
  private
  def set_shop
    @shop = Shop.find params[:id]
  end
  
end
