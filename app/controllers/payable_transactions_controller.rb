class PayableTransactionsController < ApplicationController

  def new
    @this_payable = Payable.find_by(params[:pay_id])
    @payable_transaction = @this_payable.payable_transactions.new
    #debugger
  end

  def create
    @this_payable = Payable.find(params[:pay_id])
    @payable_transaction = @this_payable.payable_transactions.build(payable_transaction_params)
    a = payable_transaction_params
    #debugger
    if @payable_transaction.save
      flash[:success] = "Transaction data added successfully."
      if (a[:cash_type] == "Cash In")
        #debugger
        @payable_transaction.payable.update_attribute(:amount, @payable_transaction.payable.amount += a[:amount].to_d)
      else
        @payable_transaction.payable.update_attribute(:amount, @payable_transaction.payable.amount -= a[:amount].to_d)
      end

      redirect_to payable_transactions_url(pay_id: @payable_transaction.payable_id)
    else
      render 'new'
    end
  end

  def index
    @payable_transaction = PayableTransaction.where(payable_id: params[:pay_id])
  end

  def payable_transaction_params
    params.require(:payable_transaction).permit(:date, :cash_type, :amount)
  end
end
