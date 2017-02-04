class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include SessionsHelper
	#include Authenticable
  # before_action :authenticate_request

  attr_reader :curr_user

  private

  def authenticate_request
    @curr_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @curr_user
    debugger
  end
end
