# frozen_string_literal: true

Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get     '/help',        to: 'static_pages#help'
  get     '/about',       to: 'static_pages#about'
  get     '/contact',     to: 'static_pages#contact'
  get     '/signup',      to: 'users#new'
  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'
  # delete  '/micropost',   to: 'microposts#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do # routes users requests per each member
    member do
      # https://guides.rubyonrails.org/routing.html#adding-member-routes
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :microposts,          only: %i[create destroy]
  resources :relationships,       only: %i[create destroy]
end


# PATH IS FOR RELATIVE URLS FROM THE BASE URL /route/:params
# URL IS THE ENTIRE URL https://www.address.com/route/:params
