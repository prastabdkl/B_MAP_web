class Api::V1::TransactionsSerializer < Api::V1::BaseSerializer
  attributes :id, :cash_type, :date, :amount, :new_created, :updated
  has_one :capitals
end
