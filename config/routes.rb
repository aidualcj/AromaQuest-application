Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'pages#home'

  resources :results, only: [:new, :create, :index, :show]
  resources :perfumes, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create]
  end

  resource :dashboard, only: [:show], controller: 'pages', action: 'dashboard' do
    get 'favorites', to: 'pages#favorites', as: :favorites
    get 'infos', to: 'pages#infos', as: :infos
    get 'results', to: 'pages#results', as: :results
    get 'apropos', to: 'pages#apropos', as: :apropos
  end

  resources :cart_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show]
  resources :orders, only: [:create, :show, :index]
end
