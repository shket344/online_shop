# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    role { FactoryBot.create(:role) }
    name { 'John' }
    surname { 'Jones' }
    email { 'one@two.com' }
    password { '162534' }
  end
end
