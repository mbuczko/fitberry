Fitberry::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  ActiveAdmin.routes(self)

  mount Resque::Server, :at => "/resque"

  resources :activities
  resources :users
  resources :teams
  resources :challanges
  resources :milestones
  resources :blogs
  resources :comments

  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
    get '/register' => 'users#register', :as => 'register'
    get '/profile/:id' => 'users#profile', :as => 'profile'

    post '/challanges/:id/activate' => 'challanges#activate', :as => 'activate'
    post '/challanges/:id/rebase' => 'challanges#rebase', :as => 'rebase'

    post '/blogs/:id/publish/' => 'blogs#publish', :as => 'publish'
    post '/blogs/:id/upload/' => 'blogs#upload'
    post '/blogs/preview' => 'blogs#preview'

    post '/comments/:id' => 'comments#create', :as => 'create_comment'
  end

  get '/comments/:id' => 'comments#index', :as => 'comments'
  get '/comments/new/:id' => 'comments#new', :as => 'new_comment'

  get '/history/:chid' => 'activities#index', :as => 'history'
  get '/highscore/:chid' => 'activities#highscore', :as => 'highscore'
  get '/blogs/:chid/:date/:direction' => 'blogs#slide'

  get  '/members' => 'teams#users'

  root :to => 'activities#index'
end
