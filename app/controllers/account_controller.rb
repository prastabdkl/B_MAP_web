# model for providing admin to manage users account
class AccountController < ApplicationController
  def new
    @account = Account.new()
  end

  def index
    redirect_to root_url
  end

  def edit
    @account = Account.find(params[:id])
    redirect_to @account.user unless current_user.is_admin
  end

  def update
    @account = Account.find(params[:id])
    @account.update_attribute(:updated, true)
    if current_user.is_admin?
      if @account.update_attributes(user_params)
        flash[:success] = 'Account updated successfully'
        @account.update_attribute(:net_total_addition, @account.addition_holiday + @account.addition_overtime + @account.addition_miscellaneous)
        @account.update_attribute(:net_total_deduction, @account.company_deduction_absent + (@account.company_deduction_wtax * @account.salary / 100) + @account.deduction_late + @account.deduction_loan + @account.deduction_miscellaneous)
        @account.update_attribute(:net_pay, @account.salary + @account.net_total_addition - @account.net_total_deduction)
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
    params.require(:account).permit(:post,
                                    :salary,
                                    :joining_date,
                                    :working_plan,
                                    :addition_holiday,
                                    :addition_overtime,
                                    :addition_miscellaneous,
                                    :deduction_loan,
                                    :deduction_late,
                                    :deduction_miscellaneous,
                                    :company_deduction_absent,
                                    :company_deduction_wtax)
  end
end
