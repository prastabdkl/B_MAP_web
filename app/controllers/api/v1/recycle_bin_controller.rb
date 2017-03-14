class Api::V1::RecycleBinController < Api::V1::BaseController
  before_action :authenticate_request, only: [:index, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    all_deleted_items = RecycleBin.all
    unless all_deleted_items.nil?
      render json: all_deleted_items, status: 200
    else
      render json: {errors: all_deleted_items.errors}, status: 404
    end
  end

  def destroy
    deleted_item = RecycleBin.find(params[:id])
    deleted_item.destroy
    head 204
  end
end
