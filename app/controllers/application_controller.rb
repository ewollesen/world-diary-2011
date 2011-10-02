class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_authorized_user
  after_filter :record_current_campaign


  protected

  def require_current_campaign
    unless current_campaign
      flash[:warn] = "No campaign set"
      redirect_to campaigns_path
    end
  end

  def current_campaign
    @campaign || Campaign.find_by_id(session["campaign_id"])
  end
  helper_method :current_campaign

  def current_campaign=(campaign)
    @campaign = campaign
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

  def record_current_campaign
    session["campaign_id"] = current_campaign.id if current_campaign
  end
end
