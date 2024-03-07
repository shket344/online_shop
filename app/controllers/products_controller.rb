# frozen_string_literal: true

class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :find_product, only: %i[show edit update]
  before_action :set_order, only: %i[show]
  before_action :find_category

  def index
    @products = Product.includes(:user).where(category: @category).page params[:page]
  end

  def show; end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to category_product_path(@product.category, @product)
    else
      render :edit
    end
  end

  private

  def find_category
    @category = Category.find_by(id: params[:category_id])
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def set_order
    return if @cart.blank?

    @order = @cart.orders.find_by(product_id: @product.id)
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :image_url, :category_id)
  end
end
