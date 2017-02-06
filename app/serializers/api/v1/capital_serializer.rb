class Api::V1::CapitalSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :description, :phone_no, :address, :total_amount,
              :capital_type, :created_at, :user_id

  has_one :user
  has_many :transactions
end
