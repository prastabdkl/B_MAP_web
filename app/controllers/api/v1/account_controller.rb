class Api::V1::AccountController < Api::V1::BaseController
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
      render json: account, status: 200, location: api_v1_account_url
    else
      render json: { errors: account.errors }, status: 422
    end
  end

  private
  def account_params
    params.require(:account).permit(:post, :salary, :joining_date, :working_plan)
  end
end
