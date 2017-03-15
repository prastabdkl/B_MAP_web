class Api::V1::TransactionsController < Api::V1::BaseController
  before_action :authenticate_request, only: [:index, :create, :get_new_created_transactions]
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
      render json: transaction, status: 201
    else
      render json: { errors: transaction.errors}, status: 406
    end
  end

  def update
    transaction = Transaction.find(params[:id])
    if transaction.update(transaction_params)
      render json: transaction, status: 200
    else
      render json: { error: transaction.errors}, status: 422
    end
  end

  def get_new_created_transactions
    new_created_transactions = Transaction.where(new_created: true);
    unless new_created_transactions.nil?
      render json: new_created_transactions, status: 200
    else
      render json: [], status: 200
    end
  end

  private

  def transaction_params
    params.permit(:date, :cash_type, :amount, :new_created, :updated)
  end
end
