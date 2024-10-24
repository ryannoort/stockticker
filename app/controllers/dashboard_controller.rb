class DashboardController < ApplicationController
  def show
    @commodity_ownerships = Current.user.commodity_ownerships
  end
end
