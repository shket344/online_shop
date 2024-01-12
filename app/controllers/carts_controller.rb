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

  def retry_order
    cart = Cart.find_by(id: params[:id])
    cart.retry_order
    RetryOrderService.call(cart)
    redirect_to user_carts_path(current_user)
  end
end
