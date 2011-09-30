Wd::Application.routes.draw do
  resources :person_uploads

  devise_for :users

  resources :people
  resources :campaigns
  resource :portal, :only => [:show]

  root :to => "portals#show"
end
