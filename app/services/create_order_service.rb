# frozen_string_literal: true

class CreateOrderService < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    create_order
  end

  private

  def create_order
    order = Order.create!(params)
    update_product_quantity
    order
  end

  def update_product_quantity
    product = Product.find_by(id: params[:product_id])
    product_quantity = product.quantity - params[:quantity].to_i
    product.update!(quantity: product_quantity)
  end
end
