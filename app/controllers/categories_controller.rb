# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.create(category_params)

    if @category.save
      redirect_to category_products_path(@category)
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_products_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def find_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
