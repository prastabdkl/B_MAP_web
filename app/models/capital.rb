# model for handeling the the payable and receivable data
class Capital < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50}
  validates :total_amount, presence: true
end
