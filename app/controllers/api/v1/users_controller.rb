include ActiveHashRelation
class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    authorize user

    render json: user
  end

  def index
    users = User.all

    users = apply_filters(users, params) # for filtering according to params value
    users = paginate(users)
    users = policy_scope(users)
    render json: users, each_serializer: Api::V1::UserSerializer, root: 'users', meta: meta_attributes(users)
  end
end
