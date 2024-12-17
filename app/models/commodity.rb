class Commodity < ApplicationRecord
  has_many :commodity_ownerships, dependent: :destroy
  has_many :commodity_transactions, dependent: :destroy
  has_many :commodity_adjustments, dependent: :destroy

  def adjust_price(price_change)
    transaction do
      update!(price: price + price_change)
      commodity_adjustments.create!(price_change: price_change)
    end
  end
end
