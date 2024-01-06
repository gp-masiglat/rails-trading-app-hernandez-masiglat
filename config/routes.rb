Rails.application.routes.draw do
  resources :stocks
  resources :transactions
  resources :users, except: [:new]

  
  get '/signup', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/home', to: 'home#index'
  get '/cash_account', to: 'cash_accounts#index'
  get '/cash_account/deposit', to: 'cash_accounts#deposit'
  get '/cash_account/widthdraw', to: 'cash_accounts#widthdraw'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
end
