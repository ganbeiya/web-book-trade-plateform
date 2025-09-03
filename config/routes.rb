
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Defines the root path route ("/")
  root "books#index"

  # account page route to account controller show
  resource :account, only: [:show, :edit, :update]
  get 'accounts/show'

  get "/selling", to: "books#selling"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # RESTful routes for books resource
  resources :books do
    # Deal with the increment or decrement for stock
    member { patch :adjust_stock }
  end

  # RESTful routes for wishlists resource
  resources :wishlists, except: [:show]

  # RESTful routes for messages resource
  resources :messages, only: [:index, :create, :new, :destroy]

  # RESTful routes for creating and managing user transactions
  resources :transactions, only: [:index, :create] do
    member do
      patch :accept
      patch :complete
    end
    collection do
      get :sent_requests
      get :received_requests
    end
  end

  # Routes for creating user reviews
  resources :user_reviews, only: [:new, :create]

  if Rails.env.development?
    mount ActionMailer::Preview => 'rails/mailers'
  end
end
