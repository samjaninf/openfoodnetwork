class CoordinatorFee < ApplicationRecord
  belongs_to :order_cycle
  belongs_to :enterprise_fee
end
