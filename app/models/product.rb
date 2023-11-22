# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)    not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_title        (title) UNIQUE
#

class Product < ApplicationRecord
  belongs_to :category

  validates :title, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
