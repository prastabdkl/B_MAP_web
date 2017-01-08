class ReceivableTransactionsController < ApplicationController

  def new
    @this_receivable = Receivable.find_by(params[:receive_id])
    @receivable_transaction = @this_receivable.receivable_transactions.new
    #debugger
  end

  def create
    @this_receivable = Receivable.find(params[:receive_id])
    #debugger
    @receivable_transaction = @this_receivable.receivable_transactions.build(receivable_transaction_params)
    a = receivable_transaction_params
    if @receivable_transaction.save
      flash[:success] = "Transaction information added successfully."
      if a[:cash_type == "Cash In"]
        @receivable_transaction.receivable.update_attribute(:amount, @receivable_transaction.receivable.amount += a[:amount].to_d)
      else
        @receivable_transaction.receivable.update_attribute(:amount, @receivable_transaction.receivable.amount -= a[:amount].to_d)
      end
      redirect_to receivable_transactions_url(receive_id: @receivable_transaction.receivable_id)
    else
      render 'new'
    end
  end

  def index
    @receivable_transaction = ReceivableTransaction.where(receivable_id: params[:receive_id])
  end

  private
  def receivable_transaction_params
    params.require(:receivable_transaction).permit(:date, :cash_type, :amount)
  end
end
