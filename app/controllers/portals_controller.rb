class PortalsController < ApplicationController

  def show
    @campaigns = Campaign.with_permissions_to(:read)
  end

end
