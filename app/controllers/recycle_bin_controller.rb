class RecycleBinController < ApplicationController
  def create
    deleted_item = RecycleBin.new(recycle_bin_params)
    deleted_item.save
  end

  def destroy
    RecycleBin.find(params[:id]).destroy
  end
end

private
def recycle_bin_params
  params.require(:recycle_bins).permit(:table_name, :corr_id, :user_id)
end
