# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    user { FactoryBot.create(:user) }
    category { FactoryBot.create(:category) }
    title { Faker::Lorem.sentences.sample }
    price { 0.01 }
  end
end
