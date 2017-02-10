class Api::V1::AuthenticationController < ApplicationController
	skip_before_action :authenticate_request

	def authenticate
		command = AuthenticateUser.call(params[:email], params[:password])
    u = User.find_by_email(params[:email])

		if command.success?
			render json: { auth_token: command.result, req_id: u.id }
		else
			render json: { error: command.errors }, status: 401
		end
	end
end
