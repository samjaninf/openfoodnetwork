class AdjustmentMetadata < ApplicationRecord
  belongs_to :adjustment, class_name: 'Spree::Adjustment'
  belongs_to :enterprise
end
