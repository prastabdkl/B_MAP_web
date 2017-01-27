# model for handeling the the payable and receivable data
class Capital < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates_presence_of :user_id
end
