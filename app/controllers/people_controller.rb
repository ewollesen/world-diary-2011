class PeopleController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update,]


  def create
    @person = current_campaign.people.build(params[:person])

    if @person.save
      flash[:notice] = "Person created successfully"
      redirect_to @person
    else
      render :action => "new"
    end
  end

  def edit
    @person = current_campaign.people.find(params[:id])
  end

  def index
    @people = current_campaign.people
  end

  def new
    @person = current_campaign.people.build(params[:person])
  end

  def show
    @person = Person.find(params[:id])
    self.current_campaign = @person.campaign
  end

  def update
    @person = current_campaign.people.find(params[:id])

    if @person.update_attributes(params[:person])
      flash[:notice] = "Person updated successfully"
      redirect_to @person
    else
      render :action => "edit"
    end
  end


end
