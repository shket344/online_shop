# frozen_string_literal: true

class ProcessOrderService < ApplicationService
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def call
    process_order
  end

  private

  def process_order
    user = cart.user
    total_price = cart.total_price

    if user.fund < total_price
      decline_order
    else
      approve_order(user, total_price)
    end
  end

  def decline_order
    cart.decline_order
    restore_products
  end

  def approve_order(user, price)
    ActiveRecord::Base.transaction do
      cart.approve_order
      user_balance = user.fund - price
      update_user_balance(user, user_balance)

      owner = User.joins(:role).find_by(role: { title: 'owner' })
      owner_balance = owner.fund + price
      update_user_balance(owner, owner_balance)
    end
  end

  def update_user_balance(user, price)
    user.update!(fund: price)
  end

  def restore_products
    cart.orders.joins(:product).find_each do |order|
      product = order.product
      new_quantity = order.quantity + product.quantity
      product.update!(quantity: new_quantity)
    end
  end
end
