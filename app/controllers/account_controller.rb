class AccountController < ApplicationController
  def new
    @account = Account.new
  end

  def index
    redirect_to root_url
  end

  def edit
    @account = Account.find(params[:id])
    redirect_to @account.user unless (current_user.is_admin)
  end

  def update
    @account = Account.find(params[:id])
    if current_user.is_admin?
      if @account.update_attributes(user_params)
        flash[:success] = "Account updated successfully"
        redirect_to @account.user
      else
        render 'edit'
      end
    else
      render root_url
    end
  end

  private
  def user_params
    params.require(:account).permit(:post, :salary, :joining_date, :working_plan)
  end
end
