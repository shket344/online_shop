# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    user { FactoryBot.create(:user) }

    trait :filled do
      user { FactoryBot.create(:user, :with_related_data) }

      after(:create) do |cart|
        user = cart.user
        Product.where(user: user).find_each do |product|
          FactoryBot.create(:order, product: product, user: user, cart: cart)
        end
      end
    end
  end
end
