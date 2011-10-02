Wd::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "log_in", sign_out: "log_out"}

  resources :people
  resources :person_uploads
  resources :campaigns
  resource :portal, :only => [:show]

  root :to => "portals#show"
end
