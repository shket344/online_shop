# frozen_string_literal: true

%w[user admin owner].each do |role|
  Role.find_or_create_by(title: role)
end

owner_role = Role.find_by(title: 'owner')

owner = User.find_by(role: owner_role) || User.create!(name: 'Owner', surname: 'Online Shop', email: 'admin@admin.com',
                                                       password: '123456789', password_confirmation: '123456789',
                                                       role: owner_role)

5.times do
  category = FactoryBot.create(:category, user: owner)
  FactoryBot.create(:product, category: category, user: owner)
end
