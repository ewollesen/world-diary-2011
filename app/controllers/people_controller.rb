class PeopleController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update,]
  before_filter :require_current_campaign, :except => [:edit, :show,]
  filter_resource_access


  def create
    if @person.save
      flash[:notice] = "Person created successfully"
      redirect_to @person
    else
      render :action => "new"
    end
  end

  def destroy
    if @person.destroy
      flash[:notice] = "Person destroyed successfully"
    else
      flash[:error] = "Error deleting person"
    end
    redirect_to people_path
  end

  def edit
    self.current_campaign = @person.campaign
    @person.uploads.build
  end

  def index
    @people = current_campaign.people
  end

  def new
    @person.uploads.build
  end

  def show
    self.current_campaign = @person.campaign
  end

  def update
    if @person.update_attributes(params[:person])
      flash[:notice] = "Person updated successfully"
      redirect_to @person
    else
      render :action => "edit"
    end
  end


  protected

  def load_person
    if "show" == params[:action]
      @person = Person.find(params[:id])
    else
      @person = current_campaign.people.find(params[:id])
    end
  end

  def new_person_from_params
    @person = current_campaign.people.build(params[:person])
  end

end
