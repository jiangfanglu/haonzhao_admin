class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :pay]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.paginate page: params[:page], per_page: 20
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/1/edit
  def edit
  end
  
  def shops
    @shops = Shop.paginate page: params[:page], per_page: 20, order: 'manufacturer_id DESC'
  end
  
  def paid_with_shop
    @transactions = Transaction.where(store_id: params[:id], status: 'Paid').paginate page: params[:page], per_page: 20
    render :index
  end
  
  def unpaid_with_shop
    @transactions = Transaction.where(store_id: params[:id], status: 'Unpaid').paginate page: params[:page], per_page: 20
    render :index
  end
  
  def shop
    @transactions = Transaction.where(store_id: params[:id]).paginate page: params[:page], per_page: 20
    render :index
  end
  
  def pay
    respond_to do |format|
      if @transaction.pay
        format.html { render text: 'SUCCESS' }
        format.json { render json: true.to_json }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def unpay
    respond_to do |format|
      if @transaction.unpay
        format.html { render text: 'SUCCESS' }
        format.json { render json: true.to_json }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:transaction_source_type, :transaction_source_id, :account_type, :store_id, :comment, :sn, :money, :money_sign)
    end
end
