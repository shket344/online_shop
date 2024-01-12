# frozen_string_literal: true

class CartsController < ApplicationController
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
