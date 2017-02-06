class Api::V1::CapitalsController < Api::V1::BaseController
  before_filter :authenticate_request
  def index
    capitals = Capital.all

    capitals = apply_filters(capitals, params)

    render json: capitals, each_serializer: Api::V1::CapitalSerializer,
                          root: 'capital'
  end
end
