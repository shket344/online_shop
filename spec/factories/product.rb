# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Lorem.sentences.sample }
    price { 0.01 }
  end
end
