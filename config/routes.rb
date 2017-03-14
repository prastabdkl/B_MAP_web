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
  resources :recycle_bins, only: [:create, :destroy]

  # for api
  namespace :api do
    namespace :v1, defaults: { format: :json} do
        # these routes are used for getting newly created rows in tables
        get 'new/users', to: 'users#get_new_created_users'
        get 'new/capitals', to: 'capitals#get_new_created_capitals'
        get 'new/transactions', to: 'transactions#get_new_created_transactions'
        get 'updated/accounts', to: 'account#get_updated_accounts'
        get 'updated/capitals', to: 'capitals#get_updated_capitals'
        get 'updated/users', to: 'users#get_updated_users'
        resources :recycle_bin, only: [:index, :destroy]
      post 'authenticate', to: 'authentication#authenticate'
      resources :sessions, only: [:create, :destroy]
      resources :users, only: [:index, :create, :show, :update, :destroy,]
      resources :account, only: [:show, :update]
      resources :capitals, only: [:create, :update, :index, :destroy]
      resources :transactions, only: [:create, :index, :update]
    end
  end
end
