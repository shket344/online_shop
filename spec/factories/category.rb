# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    title { Faker::Lorem.sentences.sample }
  end
end
