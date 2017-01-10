Rails.application.routes.draw do

  get 'red_card/new'

  post 'red_card/create'

  get 'task_queues/index'

  resources :enquetes
  get 'genre/index'

  get 'genre/show'

  get 'tweet_user/index'

  get 'tweet_user/show'

  get 'admin/index'

  get 'home/index'

  get 'home/practice' => 'home#practice'

  patch 'comments' => 'comments#update'

  devise_for :users

  resources :users, :only => [:index, :create, :show]
  resources :tweet_user, :only => [:index, :show]

  resources :comments

  resources :evaluation, :only => [:index, :new, :create]
  get 'evaluation/list'
  get 'welcome/index'

  root to: "welcome#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
