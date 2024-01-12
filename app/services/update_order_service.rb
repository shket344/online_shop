class UpdateOrderService < ApplicationService
  attr_reader :order, :params, :action

  def initialize(order, params, action)
    @order = order
    @params = params
    @action = action
  end

  def call
    case action
    when 'update' then update_order
    when 'add' then add_to_order
    when 'destroy' then destroy_order
    else
      raise StandardError
    end
  end

  private

  def update_order
    update_product_quantity
    order.update!(params)
  end

  def add_to_order
    add_product_quantity
    update_order_quantity
  end

  def destroy_order
    update_product_quantity
    order.destroy!
  end

  def update_product_quantity
    quantity = params[:quantity].to_i
    return if quantity == order.quantity

    new_quantity = quantity - order.quantity
    product_quantity = product.quantity - new_quantity
    product.update!(quantity: product_quantity)
  end

  def add_product_quantity
    quantity = product.quantity - params[:quantity].to_i
    product.update!(quantity: quantity)
  end

  def update_order_quantity
    new_quantity = order.quantity + params[:quantity].to_i
    order.update!(params.merge(quantity: new_quantity))
  end

  def product
    @product ||= order.product
  end
end
