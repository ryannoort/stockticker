class CommodityAdjustment < ApplicationRecord
  belongs_to :commodity

  validates :price_change, presence: true
  validates :commodity, presence: true
end
