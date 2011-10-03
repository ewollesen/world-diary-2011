Wd::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "log_in", sign_out: "log_out"}

  resources :people do
    get "revisions", :on => :member
  end
  resources :person_uploads
  resources :person_veil_passes, :only => [:create, :destroy, :update,]
  resources :campaigns

  resource :portal, :only => [:show]

  root :to => "portals#show"
end
