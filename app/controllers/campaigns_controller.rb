class CampaignsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update,]


  def create
    self.current_campaign = current_user.campaigns.build(params[:campaign])

    if @campaign.save
      flash["notice"] = "Campaign created successfully"
      redirect_to @campaign
    else
      render :action => "new"
    end
  end

  def edit
    self.current_campaign = current_user.campaigns.find(params[:id])
  end

  def index
    self.current_campaign = nil
    @campaigns = Campaign.all
  end

  def new
    self.current_campaign = current_user.campaigns.build(params[:campaign])
  end

  def show
    self.current_campaign = Campaign.find(params[:id])
  end

  def update
    self.current_campaign = current_user.campaigns.find(params[:id])

    if @campaign.update_attributes(params[:campaign])
      flash["notice"] = "Campaign updated successfully"
      redirect_to @campaign
    else
      render :action => "edit"
    end
  end

end
