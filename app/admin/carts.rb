# frozen_string_literal: true

ActiveAdmin.register Cart do
  includes :user
  permit_params :state, :user_id
end
