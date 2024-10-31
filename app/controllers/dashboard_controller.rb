class DashboardController < ApplicationController
  def show
    @commodities = Commodity.all
    @commodity_ownerships = Current.user.commodity_ownerships.with_total_value
  end
end
