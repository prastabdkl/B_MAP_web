class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless (current_user.is_admin? || current_user.id == @user.id)
    if current_user.nil?
      redirect_to root_url
    end
  end

  def new
    @user = User.new
    @account = Account.new
    @user.account = @account
  end

  def index
    redirect_to root_url and return unless (current_user.is_admin?)
    @user = User.where(activated: true).paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    @account = Account.new
    @user.account = @account
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = "Please check your email to activate your account"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin, :image, :address, :bank_name, :account_number, :nationality, :mobile, :home, :work)
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "Please log in"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.is_admin?
    end
end
