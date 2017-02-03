class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)
    debugger

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_auth_token
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password"}, status: 422
    end
=begin
    if user && user.authenticate(create_params[:password])
      self.current_user = user
      render json: Api::V1::SessionSerializer.new(user, root: true).to_json, status: 201
    else
      return api_error(status: 401)
    end
=end
  end

  private

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
