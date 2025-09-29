Rails.application.routes.draw do
  devise_for :users
  get 'users/show'
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/index'
  get 'flights/index'
  get 'flights/show'
  root to: "pages#home"

  resources :flights, only: [:index, :show] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'flights/search', to: 'flights#search', as: :search_flights
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
