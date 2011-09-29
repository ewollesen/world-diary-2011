class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_campaign
    @campaign || Campaign.find_by_id(session["campaign_id"])
  end
  helper_method :current_campaign

  def current_campaign=(campaign)
    @campaign = campaign
    session["campaign_id"] = campaign ? campaign.id : nil
    logger.info("set current campaign to #{session["campaign_id"]}")
  end

end
