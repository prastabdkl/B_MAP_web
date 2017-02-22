class Api::V1::AccountController < Api::V1::BaseController
  before_action :authenticate_request, only: [:show, :update]
  skip_before_action :verify_authenticity_token

  def show
    account = Account.find(params[:id])

    unless account.nil?
      render json: account, status: 200
    else
      render json: { error: "Access denied"}, status: 401
    end
  end

  def update
    account = Account.find(params[:id]) if curr_user.is_admin

    if account.update(account_params)
      account.update_attribute(:net_total_addition, account.addition_holiday + account.addition_overtime + account.addition_miscellaneous)
      account.update_attribute(:net_total_deduction, account.deduction_loan + account.deduction_late + account.deduction_miscellaneous + account.company_deduction_absent + account.salary * account.company_deduction_wtax / 100)
      account.update_attribute(:net_pay, account.salary + account.net_total_addition - account.net_total_deduction)
      render json: account, status: 200, location: api_v1_account_url
    else
      render json: { errors: account.errors }, status: 422
    end
  end

  private
  def account_params
    params.permit(:post, :salary, :joining_date, :working_plan, :addition_holiday,
                  :addition_overtime, :addition_miscellaneous, :deduction_loan,
                  :deduction_late, :deduction_miscellaneous, :company_deduction_absent,
                  :company_deduction_wtax)
  end
end
