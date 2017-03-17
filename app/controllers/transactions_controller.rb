class TransactionsController < ApplicationController
  def new
    @this_capital = Capital.find_by(id: params[:cap_id])
    @transaction = @this_capital.transactions.new
  end

  def create
    @this_capital = Capital.find_by(id: params[:cap_id])
    @transaction = @this_capital.transactions.build(transaction_params)
    if @transaction.save
      flash[:success] = 'Transaction information added successfully.'
      # add certain rules for cash in and cash out
      if @transaction.cash_type == 'Cash In'
        @this_capital.update_attribute(:total_amount, @this_capital.total_amount += @transaction.amount.to_d) if @this_capital.capital_type == "Payable"
        @this_capital.update_attribute(:total_amount, @this_capital.total_amount -= @transaction.amount.to_d) if @this_capital.capital_type == "Receivable"
      else
        @this_capital.update_attribute(:total_amount, @this_capital.total_amount -= @transaction.amount.to_d) if @this_capital.capital_type == "Payable"
        @this_capital.update_attribute(:total_amount, @this_capital.total_amount += @transaction.amount.to_d) if @this_capital.capital_type == "Receivable"
      end
      @transaction.update_attribute(:new_created, true)
      redirect_to transactions_url(cap_id: params[:cap_id])
    else
      render 'new'
    end
  end

  def index
    @transaction = Transaction.where(capital_id: params[:cap_id])
  end

  private

  def transaction_params
    params.require(:transaction).permit(:cash_type, :date, :amount)
  end
end
