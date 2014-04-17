class TransactController < ApplicationController
  
  def index
    @shops = Shop.transact.paginate page: params[:page], per_page: 20
  end

  def show
    
  end
  
end
