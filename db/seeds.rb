# frozen_string_literal: true

%w[user admin].each do |role|
  Role.find_or_create_by(title: role)
end

5.times do
  FactoryBot.create(:product)
end
