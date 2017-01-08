class PayableTransaction < ActiveRecord::Base
  belongs_to :payable
end
