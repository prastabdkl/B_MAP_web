# controller for handeling payable and receivable data
class CapitalsController < ApplicationController
  before_filter :set_capital_type, except: [:destroy, :edit, :update]
  # before_filter :chk_capital_uri

  def index
    @capital = Capital.where(capital_type: @capital_type, user_id: current_user.id)
  end

  def new
    @capital = Capital.new
    @capital.capital_type = @capital_type
    @transaction = @capital.transactions.new
  end

  def create
    @capital = current_user.capitals.build(capital_params)
    @capital.capital_type = @capital_type
    flash[:success] = 'Party successfully created.'
    if @capital.save
      if(@capital_type == 'Receivable')
        @transaction = @capital.transactions.build(cash_type: "Cash Out", date: Date.today, amount: @capital.total_amount)
      else
        @transaction = @capital.transactions.build(cash_type: "Cash In", date: Date.today, amount: @capital.total_amount)
      end
      @transaction.save
      redirect_to capitals_url(capi_type: @capital_type)
    else
      render 'new'
    end
  end

  def destroy
    Capital.find(params[:id]).destroy
    flash[:success] = 'Party deleted.'
    redirect_to capitals_url(capi_type: @capital_type)
  end

  def edit
    @capital = Capital.find(params[:id])
  end

  def update
    @capital = Capital.find(params[:id])
    @capital.update_attribute(:updated, true)
    if @capital.update_attributes(capital_params)
      flash[:success] = 'Party successfully updated'
      redirect_to capitals_url(capi_type: @capital_type)
    else
      render 'edit'
    end
  end

  private

  def capital_params
    params.require(:capital).permit(:name, :description, :phone_no, :address,
                                    :capital_type, :total_amount)
  end

  def set_capital_type
    @capital_type = params[:capi_type]
  end

  def chk_capital_uri
    if request.original_fullpath == '/capitals'
      redirect_to current_user
    end
  end
end
