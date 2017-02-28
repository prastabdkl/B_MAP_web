class Api::V1::CapitalSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :description, :phone_no, :address, :total_amount,
              :capital_type, :created_at, :user_id, :new_created, :updated

  has_one :user
  has_many :transactions
end
