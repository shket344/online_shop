# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
