class CommodityTransactionsController < ApplicationController
  def new
    @commodity = Commodity.find(params[:id])
    @commodity_transaction = Current.user.commodity_transactions.new(commodity: @commodity, transaction_type: params[:transaction_type])
  end

  def create
    @commodity = Commodity.find(params[:commodity_id])
    @commodity_transaction = Current.user.commodity_transactions.new(commodity_transaction_params.merge(commodity: @commodity))

    if CommodityTransactions::ValidateTransaction.call(commodity_transaction: @commodity_transaction)
      redirect_to root_path, notice: "Transaction successful"
    else
      render :new, alert: "Transaction failed"
    end
  end

  private

  def commodity_transaction_params
    params.require(:commodity_transaction).permit(:quantity, :transaction_type)
  end
end
