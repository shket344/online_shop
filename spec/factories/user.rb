# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    role { FactoryBot.create(:role) }
    name { 'John' }
    surname { 'Jones' }
    email { Faker::Internet.email }
    password { '162534' }

    trait :with_cart do
      after(:create) do |user|
        FactoryBot.create(:cart, user: user)
      end
    end

    trait :owner do
      role { FactoryBot.create(:role, title: 'owner') }
    end

    trait :admin do
      role { FactoryBot.create(:role, title: 'admin') }
    end

    trait :simple_user do
      role { FactoryBot.create(:role, title: 'user') }
    end
  end
end
