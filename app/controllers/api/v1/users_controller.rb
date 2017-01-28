include ActiveHashRelation
class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])

    render json: user
  end

  def index
    users = User.all

    users = apply_filters(users, params) # for filtering according to params value
    render json: users, root: 'users'
  end
end
