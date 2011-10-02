class CampaignsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update,]
  filter_resource_access


  def create
    if @campaign.save
      flash["notice"] = "Campaign created successfully"
      redirect_to @campaign
    else
      render :action => "new"
    end
  end

  def destroy
    if @campaign.destroy
      flash[:notice] = "Campaign destroyed successfully"
    else
      flash[:error] = "Error deleting campaign"
    end
    redirect_to campaigns_path
  end

  def index
    @campaigns = Campaign.with_permission_to(:read)
  end

  def update
    if @campaign.update_attributes(params[:campaign])
      flash["notice"] = "Campaign updated successfully"
      redirect_to @campaign
    else
      render :action => "edit"
    end
  end


  protected

  def load_campaign
    if "show" == params[:action]
      @campaign = Campaign.find(params[:id])
    else
      @campaign = current_user.campaigns.find(params[:id])
    end
  end

  def new_campaign_from_params
    @campaign = current_user.campaigns.build(params[:campaign])
  end
end
