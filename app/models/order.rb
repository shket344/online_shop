# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0)
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_cart_id     (cart_id)
#  index_orders_on_product_id  (product_id)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  include AASM
  include DateParser

  belongs_to :product
  belongs_to :user
  belongs_to :cart

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  aasm column: :status do
    state :created, initial: true
    state :processing, :approved, :declined

    event :book do
      transitions from: :created, to: :processing
    end

    event :approve do
      transitions from: :processing, to: :approved
    end

    event :decline do
      transitions from: :processing, to: :declined
    end
  end

  def total
    product.price * quantity
  end
end
