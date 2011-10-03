class PeopleController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update, :changes]
  before_filter :require_current_campaign, :except => [:edit, :show,]
  filter_resource_access :additional_member => {:changes => :update}


  def revisions
    if params.include?(:rev_right) && params.include?(:rev_left)
      @rev_left = @person.versions[params[:rev_left].to_i]
      @rev_right = @person.versions[params[:rev_right].to_i]
    else
      @rev_left = @person.versions[-1]
      @rev_right = nil
    end
    @person_left = @rev_left ? @person.versions[@rev_left.index].reify : @person
    @person_right = @rev_right ? @person.versions[@rev_right.index].reify : @person
  end

  def create
    if @person.save
      flash[:notice] = "Person created successfully"
      redirect_to @person
    else
      @person.uploads.build
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
    @people = current_campaign.people.with_permissions_to(:read)
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
      @person.uploads.build
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
