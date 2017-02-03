class Api::V1::SessionsSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :name, :is_admin, :token

  def auth_token
    object.auth_token
  end
end
