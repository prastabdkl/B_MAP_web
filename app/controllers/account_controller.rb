class AccountController < ApplicationController
  def new
    @account = Account.new
  end

  def edit
    @account = Account.find(params[:id])
    render 'edit'
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(user_params)
      flash[:success] = "Account updated successfully"
      redirect_to @account.user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:account).permit(:post, :salary, :joining_date, :working_plan)
  end
end
