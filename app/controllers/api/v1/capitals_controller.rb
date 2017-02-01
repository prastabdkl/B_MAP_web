class Api::V1::CapitalsController < Api::V1::BaseController
  before_filter :authenticate_token
  before_filter :authenticate_user!

  def index
    user = authenticate_token
    debugger
    capitals = Capital.all

    capitals = apply_filters(capitals, params)

    render json: capitals.to_json, each_serializer: Api::V1::CapitalSerializer,
                          root: 'capitals'
  end
end
