authorization do
  role :guest do
    has_permission_on :campaigns, :to => :read do
      if_attribute :private => is {false}
    end
  end

  role :user do
    includes :guest

    has_permission_on :campaigns, :to => :create
    has_permission_on :campaigns, :to => :manage do
      if_attribute :dm => is {user}
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
