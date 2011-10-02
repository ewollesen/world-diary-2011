authorization do
  role :guest do
    has_permission_on :campaigns, :to => :read do
      if_attribute :private => is {false}
    end

    has_permission_on :people, :to => :read, :join_by => :and do
      if_attribute :private => is {false}
      if_permitted_to :read, :campaign
    end

    has_permission_on :person_uploads, :to => :read, :join_by => :and do
      if_attribute :private => is {false}
      if_permitted_to :read, :person
    end
  end

  role :user do
    includes :guest

    has_permission_on :campaigns, :to => :create
    has_permission_on :campaigns, :to => :manage do
      if_attribute :dm => is {user}
    end

    has_permission_on :people, :to => :create
    has_permission_on :people, :to => :manage do
      if_permitted_to :manage, :campaign
    end

    has_permission_on :person_uploads, :to => :create
    has_permission_on :person_uploads, :to => :read do
      if_permitted_to :manage, :person
    end
  end
end


privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
