class Api::V1::CapitalsController < Api::V1::BaseController
  before_action :authenticate_request, only: [:index, :create, :update, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    capitals = Capital.where(user_id: curr_user.id, capital_type: params[:capi_type])

    capitals = apply_filters(capitals, params)

    render json: capitals, each_serializer: Api::V1::CapitalSerializer,
                          root: 'capital'
  end

  def create
    capitals = Capital.where(user_id: curr_user.id)
    #debugger
    capital = curr_user.capitals.new(capital_params)
    if capital.save
      render json: capitals, each_serializer: Api::V1::CapitalSerializer, status: 201
    else
      render json: { errors: capital.errors}, status: 422
    end
  end

  def update
    capitals = Capital.where(user_id: curr_user.id)
    capital = Capital.find(params[:id])
    if capital.update(capital_params)
      render json: capitals, status: 200
    else
      render json: { errors: capital.errors}, capi_type: params[:capital_type], status: 422
    end
  end

  def destroy
    capital = Capital.find(params[:id])
    capital.destroy
    head 204
  end

  def get_updated_capitals
    updated_capitals = Capital.where(updated: true)
    unless updated_capitals.nil?
      render json: updated_capitals, status: 200
    else
      render json: [], status:200
    end
  end

  def get_new_created_capitals
    new_created_capitals = Capital.where(new_created: true)
    unless new_created_capitals.nil?
      render json: new_created_capitals, status: 200
    else
      render json: [], status: 200
    end
  end

  private

  def capital_params
    params.permit(:name, :description, :phone_no, :address, :total_amount, :capital_type)
  end
end
