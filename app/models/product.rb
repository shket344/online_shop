# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)    not null
#  quantity    :integer          default(0)
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_title        (title) UNIQUE
#  index_products_on_user_id      (user_id)
#

class Product < ApplicationRecord
  has_many :orders

  belongs_to :category
  belongs_to :user

  validates :title, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
