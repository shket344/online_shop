# frozen_string_literal: true

ActiveAdmin.register Order do
  includes :cart, :product, :user
  permit_params :status, :quantity, :cart_id, :product_id, :user_id
end
