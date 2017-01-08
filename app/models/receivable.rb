class Receivable < ActiveRecord::Base
  belongs_to :user
  has_many :receivable_transactions
  # mount_uploader :img, ImageUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum:50}
  validates :amount, presence: true
end
