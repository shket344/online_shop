# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    user { FactoryBot.create(:user) }
    title { Faker::Lorem.sentences.sample }
  end
end
