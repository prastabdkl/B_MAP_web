class Api::V1::CapitalsController < Api::V1::BaseController
  before_action :authenticate_request, only: :index
  skip_before_action :verify_authenticity_token
  def index
    capitals = Capital.all

    capitals = apply_filters(capitals, params)

    render json: capitals, each_serializer: Api::V1::CapitalSerializer,
                          root: 'capital'
  end
end
