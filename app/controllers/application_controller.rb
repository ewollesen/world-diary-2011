class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_authorized_user


  protected

  def current_campaign
    @campaign || Campaign.find_by_id(session["campaign_id"])
  end
  helper_method :current_campaign

  def set_current_campaign(campaign=nil)
    campaign ||= @campaign
    session["campaign_id"] = campaign ? campaign.id : nil
    logger.info("set current campaign to #{session["campaign_id"]}")
  end

  def set_authorized_user
    Authorization.current_user = current_user
  end

  def permission_denied
    if current_user
      flash[:error] = "Permission denied."
      redirect_to root_path
    else
      authenticate_user!
    end
  end
end
