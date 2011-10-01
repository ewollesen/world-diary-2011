class PortalsController < ApplicationController

  def show
    @campaigns = Campaign.scoped
  end

end
