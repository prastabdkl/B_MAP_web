class Api::V1::BaseController < ApplicationController
	include Pundit
  include ActiveHashRelation

  # Prevent CSRF accack by raising an exception
  # for api with token authentication we may user :null_session instead
  protect_from_forgery with: :exception
  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized!

  attr_accessor :current_user
  protected

	def auth_request
		@current_user = Api::V1::ApplicationController::AuthorizedApiRequest.call(request.headers).result
		render json: { error: 'Not Authorized' }, status: 401 unless @current_user
	end

	def require_login
		authenticate_token ||= render_unauthorized("Access denied")
	end

	def current_user
		@current_user ||= authenticate_token
	end

	protected

	def render_unauthorized(message)
		errors = { errors: [ { detail: message }]}
		render json: errors, status: :unauthorized
	end

  def destroy_session
    request.session_options[:skip] = true
	end

	def not_found
		return api_error(status: 404, errors: 'Not found')
	end
	private

	def authenticate_token
		authenticate_with_http_token do |token, options|
			# Compare the tokens in a time-constant manner, to mitigate timing attacks.
			User.find_by(auth_token: token)
				ActiveSupport::SecurityUtils.secure_compate(
													::Digest::SHA256.hexdigest(token),
													::Digest::SHA256.hexdigest(user.token))
				user
		end
	end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials'}, status: 401
  end

  def unauthorized!
    render json: { error: 'not authorized' }, status: 403
  end

  def invalid_resource!(errors = [])
    api_error(status: 422, errors: errors)
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: jsonapi_format(errors).to_json, status: status
  end

  def paginate(resource)
    resource = resource.page(params[:page] || 1)
    if params[:per_page]
      resource = resource.per_page(params[:per_page])
    end
    return resource
  end

  def meta_attributes(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank?? nil : options[:email]
    user = user_email && User.find_by(email: user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      return unauthenticated!
    end
  end
end
