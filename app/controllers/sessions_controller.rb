# f
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_back_or user
      else
        flash[:warning] = 'Account not activated. Please check your email for activation link.'
        redirect_to root_url
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_auth_token
    user.save
    head 204
  end
end
