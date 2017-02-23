class Api::V1::TransactionsController < Api::V1::BaseController
  before_action :authenticate_request, only: [:index, :create]
  skip_before_action :verify_authenticity_token

  def index
    transactions = Transaction.where(capital_id: params[:cap_id])

    unless transactions.nil?
      render json: transactions, each_serializer: Api::V1::TransactionsSerializer, root: false
    else
      render json: { errors: transactions.errors}, status: 422
    end
  end

  def create
    # remember to send capital_id as parameter while calling create action
    transactions = Transaction.all
    capital = Capital.find(params[:capital_id])
    transaction = capital.transactions.new(transaction_params)

    if transaction.save
      if transaction.cash_type == 'Cash In'
        capital.update_attribute(:total_amount, capital.total_amount += transaction.amount.to_d) if capital.capital_type == "Payable"
        capital.update_attribute(:total_amount, capital.total_amount -= transaction.amount.to_d) if capital.capital_type == "Receivable"
      else
        capital.update_attribute(:total_amount, capital.total_amount -= transaction.amount.to_d) if capital.capital_type == "Payable"
        capital.update_attribute(:total_amount, capital.total_amount += transaction.amount.to_d) if capital.capital_type == "Receivable"
      end
      render json: transactions, status: 201
    else
      render json: { errors: "transaction.errors"}, status: 406
    end
  end

  private

  def transaction_params
    params.permit(:date, :cash_type, :amount)
  end
end
