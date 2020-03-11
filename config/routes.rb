Rails.application.routes.draw do
  #toppage
  root to: 'toppages#index'
  resources :toppages , only: [:index] do
    collection do
      get :populars
      get :likes
    end
  end
  
  #user
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  #session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #review
  resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get :comment
    end
  end
  
  #comment
  resources :comments, only: [:create, :destroy]
  
  #relationship
  resources :relationships, only: [:create, :destroy]
  
  #like
  resources :likes, only: [:create, :destroy]
  
  #search
  get 'search', to: 'searchs#search'
  get 'search1', to: 'searchs#shopsearch'
  get 'search2', to: 'searchs#genresearch'
end
