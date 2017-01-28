class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :is_admin, :activated, :created_at

  # has_one :account
  # has_many :capitals
end
