# frozen_string_literal: true

class RetryOrderService < ApplicationService
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def call
    retry_order
  end

  private

  def retry_order
    available? ? make_order : cart.decline_order
  end

  def available?
    orders.map do |order|
      order.quantity <= order.product.quantity
    end.all?(true)
  end

  def make_order
    orders.find_each do |order|
      product = order.product
      new_quantity = product.quantity - order.quantity
      product.update!(quantity: new_quantity)
    end

    ProcessOrderWorker.perform_async(cart.id)
  end

  def orders
    @orders ||= cart.orders.includes(product: :category)
  end
end
