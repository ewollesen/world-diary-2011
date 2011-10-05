class PeopleController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :new, :update, :changes]
  before_filter :require_current_campaign, :except => [:edit, :show, :update,]
  filter_resource_access :additional_member => {:changes => :update}


  def revisions
    @rev_left = params[:rev_left].to_i - 1
    @rev_right = params[:rev_right].to_i - 1
    @ver_left = @person.versions[@rev_left]
    @ver_right = @person.versions[@rev_right]
    @person_left = @ver_left ? @ver_left.reify : @person
    @person_right = @ver_right ? @ver_right.reify : @person
  end

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

  def index
    @people = current_campaign.people.with_permissions_to(:read)
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
    if ["edit", "show", "update",].include?(params[:action])
      @person = Person.find(params[:id])
      self.current_campaign = @person.campaign
    else
      @person = current_campaign.people.find(params[:id])
    end
  end

  def new_person_from_params
    @person = current_campaign.people.build(params[:person])
  end

end
