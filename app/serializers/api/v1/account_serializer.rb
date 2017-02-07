class Api::V1::AccountSerializer < Api::V1::BaseSerializer
  attributes :id, :post, :salary, :joining_date, :working_plan

  has_one :user
end
