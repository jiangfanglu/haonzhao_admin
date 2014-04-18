class TransactController < ApplicationController
  
  def index
    @shops = Shop.transact.paginate page: params[:page], per_page: 20
  end

  def show
    @shop = Shop.find params[:id]
    @transactions = Transaction.all_by_shop @shop.id
    render :_show
  end
  
  def paid_by_shop
    @shop = Shop.find params[:id]
    @transactions = Transaction.paid_by_shop @shop.id
    render :paid
  end

  def unpaid_by_shop
    @shop = Shop.find params[:id]
    @transactions = Transaction.unpaid_by_shop @shop.id
    render :unpaid
  end
  
  def treat_transactions
    
  end
  
end
