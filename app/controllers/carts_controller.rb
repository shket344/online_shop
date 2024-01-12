# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @carts = Cart.where(user: current_user).preload(:orders).includes(orders: [product: :category]).order(:created_at)
  end

  def show
    @orders = @cart.orders.includes(product: :category)
  end

  def make_order
    @cart.make_order
    ProcessOrderWorker.perform_async(@cart.id)
    session[:cart_id] = nil
    redirect_to :root
  end
end
