# model for handeling the transaction information
class Transaction < ActiveRecord::Base
  belongs_to :capitals
  validates_presence_of :capital_id
end
