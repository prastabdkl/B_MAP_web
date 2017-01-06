class ReceivablesController < ApplicationController

    def index
      @receivable = Receivable.where(user_id: current_user.id)
    end

    def new
      @receivable = Receivable.new
    end

    def create
      @receivable = current_user.receivables.build(receivable_params)
      if @receivable.save
        flash[:success] = "Party successfully created"
        redirect_to action: "index"
      else
        render 'new'
      end
    end

    def edit
      @receivable = Receivable.find(params[:id])
    end

    def update
      @receivable = Receivable.find(params[:id])
      if @receivable.update_attributes(receivable_params)
        flash[:success] = "Receivable Party successfully updated"
        redirect_to action: "index"
      else
        render 'edit'
      end
    end

    def destroy
      Receivable.find(params[:id]).destroy
      flash[:success] = "Party successfully deleted"
      redirect_to action: "index"
    end

    private
    def receivable_params
      params.require(:receivable).permit(:date, :name, :description, :phone_no, :address, :img, :amount)
    end
end
