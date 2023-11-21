# frozen_string_literal: true

5.times do |iterator|
  price = "0.#{iterator}"
  title = Faker::Beer.brand
  Product.create(title: title, price: price)
end
