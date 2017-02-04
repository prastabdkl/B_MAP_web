class Api::V1::UsersController < Api::V1::BaseController
	include ActiveHashRelation
	before_action :authenticate_with_token!, only: [:update, :destroy]
	before_action :authenticate_request
	respond_to :json

  def show
    user = User.find(params[:id]) if params[:id].to_i == curr_user.id || curr_user.is_admin

		unless user.nil?
    	render json: user
		else
			render json: { error: "Access denied"}, status: 404
		end
  end

  def index
    users = User.all if curr_user.is_admin
		if users.nil?
			render json: { error: "Access denied"}, status: 404
		else
			users = apply_filters(users, params) # for filtering according to params value
		  users = paginate(users)
		  users = policy_scope(users)
		  render json: users, each_serializer: Api::V1::UserSerializer, root: 'users', meta: meta_attributes(users)
		end
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
