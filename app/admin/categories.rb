# frozen_string_literal: true

ActiveAdmin.register Category do
  includes :user

  permit_params :title, :user_id
end
