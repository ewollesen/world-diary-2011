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

  def destroy
    @person = current_campaign.people.find(params[:id])

    if @person.destroy
      flash[:notice] = "Person destroyed successfully"
    else
      flash[:error] = "Error deleting person"
    end
    redirect_to people_path
  end

  def edit
    @person = current_campaign.people.find(params[:id])
    @person.uploads.build
  end

  def index
    @people = current_campaign.people
  end

  def new
    @person = current_campaign.people.build(params[:person])
    @person.uploads.build
  end

  def show
    @person = Person.find(params[:id])
    set_current_campaign(@person.campaign)
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
