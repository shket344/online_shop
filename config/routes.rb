# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'categories#index'

  devise_scope :user do
    get '/users/sign_up', to: 'devise/registrations#new'
    get '/users/sign_in', to: 'devise/sessions#new'
    get '/users/sign_out', to: 'devise/sessions#destroy'
    get '/users/:id', to: 'users#show', as: 'user'
    delete '/users/:id/destroy', to: 'users#destroy', as: 'destroy_user'
    get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  end

  devise_for :users

  ActiveAdmin.routes(self)

  resources :users, only: %i[show] do
    resources :categories do
      resources :products
    end
  end

  resources :categories, only: %i[index] do
    resources :products, only: %i[index show]
  end
end
