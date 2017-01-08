class Payable < ActiveRecord::Base
  belongs_to :user
  has_many :payable_transactions
  # mount_uploader :img, ImageUploader
  validates :user_id, presence: true
  validates :name, presence: true
  validates :amount, presence: true
end
