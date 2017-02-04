Rails.application.routes.draw do
  resources :account, only: [:new, :create, :edit, :update, :destroy]
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
  resources :capitals
  resources :transactions
  match '/help', to: 'static_pages#help', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
  root 'static_pages#home'

  # for api
  namespace :api do
    namespace :v1, defaults: { format: :json} do
			post 'authenticate', to: 'authentication#authenticate'
      resources :sessions, only: [:create, :destroy]
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :account, only: [:update]
      resources :capitals, only: [:create, :update, :index, :destroy]
      resources :transactions, only: [:create, :index]
    end
  end
end
