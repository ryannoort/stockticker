class AdjustCommodityJob < ApplicationJob
  def perform
    commodity = Commodity.order("RANDOM()").first
    event = [:up, :down, :dividend].sample
    price_change = [5, 10, 20].sample

    case event
    when :up
      commodity.adjust_price(price_change)
      Rails.logger.info "Price increase of #{price_change} for #{commodity.name}"
    when :down
      commodity.adjust_price(-price_change)
      Rails.logger.info "Price decrease of #{price_change} for #{commodity.name}"
    when :dividend
      Rails.logger.info "Dividend of #{price_change} for #{commodity.name}"
    end
  end
end
