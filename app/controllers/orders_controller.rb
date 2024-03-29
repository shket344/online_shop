# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[update_order add remove_order]

  def update_order
    UpdateOrderService.call(@order, order_params, 'update')
    redirect_to user_cart_path(current_user, @cart)
  end

  def add
    if @order
      UpdateOrderService.call(@order, order_params, 'add')
    else
      @order = CreateOrderService.call(order_params.merge(cart_id: @cart.id, user_id: current_user.id))
    end

    redirect_to user_cart_path(current_user, @cart)
  end

  def remove_order
    UpdateOrderService.call(@order, order_params, 'destroy')
    redirect_to user_cart_path(current_user, @cart)
  end

  private

  def order_params
    params.permit(:product_id, :quantity)
  end

  def set_order
    @order = Order.find_by(id: params[:id])
  end
end
