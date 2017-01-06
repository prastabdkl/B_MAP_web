class PayablesController < ApplicationController

  def index
    @payable = Payable.where(user_id: current_user.id)
  end

  def new
    @payable = Payable.new
  end

  def create
    #debugger
    @payable = current_user.payables.build(payable_params)
    if @payable.save
      flash[:success] = "Party successfully created"
      #debugger
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def edit
    @payable = Payable.find(params[:id])
  end

  def update
    @payable = Payable.find(params[:id])
    if @payable.update_attributes(payable_params)
      flash[:success] = "Payable Party successfully updated"
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    Payable.find(params[:id]).destroy
    flash[:success] = "Party deleted"
    redirect_to action: "index"
  end

  private
  def payable_params
    params.require(:payable).permit(:date, :name, :description, :phone_no, :address, :img, :amount)
  end
end
