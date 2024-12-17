class Commodity < ApplicationRecord
  has_many :commodity_ownerships, dependent: :destroy
  has_many :commodity_transactions, dependent: :destroy
  has_many :commodity_adjustments, dependent: :destroy

  def adjust_price(price_change)
    transaction do
      self.price += price_change
      commodity_adjustments.create!(price_change: price_change)

      if self.price <= 0
        Rails.logger.info "Price of #{name} is negative"
        commodity_ownerships.each do |ownership|
          ownership.destroy!
        end

        self.price = 100
      end

      save!
    end
  end
end

