# model for handeling the transaction information
class Transaction < ActiveRecord::Base
  belongs_to :capitals
  validates_presence_of :capital_id
  validates_presence_of :cash_type
  validates_presence_of :amount
  validates :date, presence: true
end
