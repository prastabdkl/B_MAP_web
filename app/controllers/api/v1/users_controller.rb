class Api::V1::UsersController < Api::V1::BaseController
	include ActiveHashRelation
	before_action :authenticate_request, only: [:show, :index, :update, :destroy]
	skip_before_action :verify_authenticity_token
	respond_to :json

  def show
    user = User.find(params[:id]) if params[:id].to_i == curr_user.id || curr_user.is_admin

		unless user.nil?
			render json: user, status: 200
		else
			render json: { error: "Access denied"}, status: 401
		end
  end

  def index
    users = User.all if curr_user.is_admin
		if users.nil?
			render json: { error: "Access denied"}, status: 401
		else
			users = apply_filters(users, params) # for filtering according to params value
		  users = paginate(users)
		  users = policy_scope(users)
		  render json: users, each_serializer: Api::V1::UserSerializer, root: true, meta: meta_attributes(users)
		end
  end

	def update
		user = User.find(params[:id])
	# debugger
		if user.update(user_params)
			render json: user, status: 200, location: api_v1_user_url
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		head 204
	end

	private

	def user_params
		params.permit(:name, :email, :password, :password_confirmation, :is_admin, :address, :bank_name, :account_number, :nationality, :mobile, :home, :work)
	end
end
