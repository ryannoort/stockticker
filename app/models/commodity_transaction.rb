class CommodityTransaction < ApplicationRecord
  TYPE_SALE='sale'.freeze
  TYPE_PURCHASE='purchase'.freeze

  belongs_to :commodity
  belongs_to :user

  validates :commodity_id, presence: true
  validates :user_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: [TYPE_SALE, TYPE_PURCHASE] }
end
