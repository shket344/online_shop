# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { FactoryBot.create(:user) }
    product { FactoryBot.create(:product) }
    quantity { 3 }
  end
end
