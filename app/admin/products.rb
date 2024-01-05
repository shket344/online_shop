# frozen_string_literal: true

ActiveAdmin.register Product do
  includes :user, :category

  permit_params :title, :description, :image_url, :price, :quantity, :category_id, :user_id
end
