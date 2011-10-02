class CampaignsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update,]
  filter_resource_access


  def create
    @campaign = current_user.campaigns.build(params[:campaign])

    if @campaign.save
      flash["notice"] = "Campaign created successfully"
      redirect_to @campaign
    else
      render :action => "new"
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])

    if @campaign.destroy
      flash[:notice] = "Campaign destroyed successfully"
    else
      flash[:error] = "Error deleting campaign"
    end
    redirect_to campaigns_path
  end

  def edit
    self.current_campaign = current_user.campaigns.find(params[:id])
  end

  def index
    set_current_campaign
    @campaigns = Campaign.all
  end

  def new
    @campaign = current_user.campaigns.build(params[:campaign])
  end

  def show
    set_current_campaign
  end

  def update
    @campaign = current_user.campaigns.build(params[:campaign])

    if @campaign.update_attributes(params[:campaign])
      flash["notice"] = "Campaign updated successfully"
      redirect_to @campaign
    else
      render :action => "edit"
    end
  end
end
