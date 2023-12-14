# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    title { Faker::Lorem.sentences.sample }
  end
end
