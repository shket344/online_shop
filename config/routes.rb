# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'products#index'

  resources :products
  # delete '/products/:id', to: 'products#destroy', as: 'destroy_product'
end
