# model for handeling the transaction information
class Transaction < ActiveRecord::Base
  belongs_to :capitals
  validates :capital_id, presence: true
  validates :cash_type, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :capital_id, presence: true
end
