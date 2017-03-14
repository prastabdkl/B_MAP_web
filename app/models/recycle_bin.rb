class RecycleBin < ActiveRecord::Base
  validates :corr_id, :presence
  validates :table_name, :presence
end
