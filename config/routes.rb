RedditClone::Application.routes.draw do
  root :to => 'subs#index'

  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create]
  resources :subs
  resources :links
end