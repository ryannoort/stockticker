class Commodity < ApplicationRecord
  has_many :commodity_ownerships, dependent: :destroy
  has_many :commodity_transactions, dependent: :destroy
  has_many :commodity_adjustments, dependent: :destroy

  def adjust_price(price_change)
    transaction(lock: true) do
      self.price += price_change
      commodity_adjustments.create!(price_change: price_change)

      if self.price <= 0
        Rails.logger.info "Price of #{name} has dropped to zero. Destroying all commodity_ownerships"
        commodity_ownerships.destroy_all

        self.price = 100
      elsif self.price >= 200
        Rails.logger.info "Price of #{name} is above 200. Splitting the stocks"
        commodity_ownerships.update_all("quantity = quantity * 2")

        self.price = 100
      end

      save!
    end
  end
end

