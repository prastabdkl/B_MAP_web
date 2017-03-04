class Api::V1::UsersController < Api::V1::BaseController
	include ActiveHashRelation
	before_action :authenticate_request, only: [:show, :index, :update, :destroy, :get_new_created_users, :get_updated_users]
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

	def create
		user = User.new(user_params)
		account = Account.new
		user.account = account
		if user.save
			if curr_user.is_admin
				user.update_attribute(:activated, true)
				user.update_attribute(:activated_at, Time.now)
				render json: user, status: 201
			else
				render json: { error: "Only for admin"}, staus: 406
			end
		else
			render json: { error: user.errors }, status: 406
		end
	end

  def index
    users = User.all if curr_user.is_admin
		if users.nil?
			render json: { error: "Access denied"}, status: 401
		else
			#users = apply_filters(users, params) # for filtering according to params value
		  #users = paginate(users)
		  #users = policy_scope(users)
		  render json: users, each_serializer: Api::V1::UserSerializer, status: 200 #root: true, meta: meta_attributes(users)
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

	def get_new_created_users
		new_created_users = User.where(new_created: true)
		unless new_created_users.nil?
			render json: new_created_users, status: 200
		else
			render json: [], status: 200
		end
	end

	def get_updated_users
		updated_users = User.find_by(updated: true)
		unless updated_users.nil?
			render json: updated_users, status: 200
		else
			render json: [], status: 200
		end
	end

	private

	def user_params
		params.permit(:name, :email, :password, :password_confirmation, :is_admin, :address, :bank_name, :account_number, :nationality, :mobile, :home, :work, :new_created, :updated)
	end
end
