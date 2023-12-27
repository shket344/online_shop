# frozen_string_literal: true

class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :find_product, only: %i[show edit update destroy]
  before_action :find_category

  def index
    @products = Product.includes(:user).where(category: @category)
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    user = User.find_by(id: params[:user_id])
    @product = Product.create(product_params.merge(category_id: @category.id, user_id: user.id))

    if @product.save
      redirect_to category_product_path(@product.category, @product)
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to category_product_path(@product.category, @product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def find_category
    @category = Category.find_by(id: params[:category_id])
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:user_id, :title, :description, :price, :image_url, :category_id)
  end
end
