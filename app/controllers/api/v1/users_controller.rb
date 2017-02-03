class Api::V1::UsersController < Api::V1::BaseController
	include ActiveHashRelation
	before_action :authenticate_with_token!, only: [:update, :destroy]
	respond_to :json

  def show
    user = User.find(params[:id])
    # authorize user

    render json: user
  end

  def index
    users = User.all

    users = apply_filters(users, params) # for filtering according to params value
    users = paginate(users)
    users = policy_scope(users)
    render json: users, each_serializer: Api::V1::UserSerializer, root: 'users', meta: meta_attributes(users)
  end

	def update
		user = current_user

		if user.update(user_params)
			render json: user, status: 200, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	def destroy
		current_user.destroy
		head 204
	end
end
