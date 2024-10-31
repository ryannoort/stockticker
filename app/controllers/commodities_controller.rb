class CommoditiesController < ApplicationController
  # def index
  #   @commodities = Commodity.all
  # end

  def show
    @commodity = Commodity.find(params[:id])
    @commodity_owned = Current.user.commodity_ownerships.find_by(commodity_id: @commodity.id)&.quantity || 0
  end
end
