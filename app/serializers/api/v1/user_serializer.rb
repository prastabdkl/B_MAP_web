class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :email, :is_admin, :activated, :created_at, :activated,
             :address, :bank_name, :account_number, :nationality, :mobile,
             :home, :work, :image

  has_one :account
  has_many :capitals
end
