# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { FactoryBot.create(:user, :with_cart) }
    product { FactoryBot.create(:product) }
    cart { Cart.find_by(user_id: user&.id) }
    quantity { 3 }
  end
end
