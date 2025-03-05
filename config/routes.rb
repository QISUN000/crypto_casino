Rails.application.routes.draw do
  get "pages/home"
  get "pages/about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'pages#home'

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get 'about', to: 'pages#about'
  # Defines the root path route ("/")
  # root "posts#index"

  resources :cryptocurrencies
  resources :categories
  resources :gamblers
  resources :casino_tables
  resources :bets

  get 'search', to: 'search#index'
end
