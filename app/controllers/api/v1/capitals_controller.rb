class Api::V1::CapitalsController < Api::V1::BaseController
  before_action :authenticate_request, only: :index
  skip_before_action :verify_authenticity_token

  def index
    capitals = Capital.where(user_id: curr_user.id)

    capitals = apply_filters(capitals, params)

    render json: capitals, each_serializer: Api::V1::CapitalSerializer,
                          root: 'capital'
  end

  def update
    capitals = Capital.where(user_id: curr_user.id)
    capital = Capital.find(params[:id])
    if capital.update(capital_params)
      render json: capitals, status: 200
    else
      render json: { errors: capital.errors}, status: 422
    end
  end

  def destroy
    capital = Capital.find(params[:id])
    capital.destroy
    head 204
  end

  private

  def capital_params
    params.permit(:name, :description, :phone_no, :address, :total_amount, :capital_type)
  end
end
