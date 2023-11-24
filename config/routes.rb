# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'categories#index'

  resources :categories, only: %i[index new create edit update destroy] do
    resources :products
  end
end
