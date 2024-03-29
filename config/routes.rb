# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'categories#index'

  devise_scope :user do
    get '/users/sign_up', to: 'devise/registrations#new'
    get '/users/sign_in', to: 'devise/sessions#new'
    get '/users/sign_out', to: 'devise/sessions#destroy'
    get '/users/:id', to: 'users#show', as: 'user'
    post '/users/:id/add_funds', to: 'users#add_funds', as: 'user_add_funds'
    delete '/users/:id/destroy', to: 'users#destroy', as: 'destroy_user'
    get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  end

  devise_for :users

  ActiveAdmin.routes(self)

  resources :users, only: %i[show] do
    resources :categories do
      resources :products
    end

    resources :carts, only: %i[index show]
    get '/carts/:id/make_order', to: 'carts#make_order', as: 'make_order'
    get '/carts/:id/retry_order', to: 'carts#retry_order', as: 'retry_order'
    get '/carts/:id/repeat_order', to: 'carts#repeat_order', as: 'repeat_order'
    post '/orders/add', to: 'orders#add'
    post '/orders/update_order', to: 'orders#update_order'
    get '/orders/:id/remove_order', to: 'orders#remove_order', as: 'remove_order'
  end

  resources :categories, only: %i[index] do
    get '/page/:page', action: :index, on: :collection
    resources :products, only: %i[index show]
  end

  mount Sidekiq::Web => '/sidekiq'
end
