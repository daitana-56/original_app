Rails.application.routes.draw do
  #toppage
  root to: 'toppages#index'
  
  #user
  get 'signup', to: 'users#new'
  resources :users
  
  #session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
