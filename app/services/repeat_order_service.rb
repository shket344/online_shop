# frozen_string_literal: true

class RepeatOrderService < ApplicationService
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def call
    retry_order
  end

  private

  def retry_order
    available? ? repeat_order : cart.approve_order
  end

  def available?
    orders.map do |order|
      order.quantity <= order.product.quantity
    end.all?(true)
  end

  def repeat_order
    ActiveRecord::Base.transaction do
      new_cart = Cart.create!(user_id: cart.user_id, state: :processing)
      orders.find_each do |order|
        new_order = order.dup
        new_order.cart_id = new_cart.id
        new_order.status = :processing
        new_order.save!
        update_product_quantity(order)
      end

      cart.approve_order
      ProcessOrderWorker.perform_async(new_cart.id)
    end
  end

  def update_product_quantity(order)
    product = order.product
    new_quantity = product.quantity - order.quantity
    product.update!(quantity: new_quantity)
  end

  def orders
    @orders ||= cart.orders.includes(product: :category)
  end
end
