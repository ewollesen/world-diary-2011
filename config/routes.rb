Wd::Application.routes.draw do
  devise_for :users

  resources :people
  resources :campaigns
  resource :portal, :only => [:show]

  root :to => "portals#show"
end
