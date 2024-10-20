class CommodityOwnership < ApplicationRecord
  belongs_to :commodity
  belongs_to :user

  validates :commodity_id, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
  validates :commodity_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
