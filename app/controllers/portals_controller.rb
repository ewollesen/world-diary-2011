class PortalsController < ApplicationController

  def show
    @campaigns = Campaign.all
  end

end
