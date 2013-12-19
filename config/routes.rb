RedditClone::Application.routes.draw do
  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create]
end