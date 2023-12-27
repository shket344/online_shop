# frozen_string_literal: true

class CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :find_category, only: %i[edit update destroy]

  def index
    @categories = Category.order(:title)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    user = User.find_by(id: params[:user_id])
    @category = Category.create(category_params.merge(user_id: user.id))

    if @category.save
      redirect_to user_category_products_path(user, @category)
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
    params.require(:category).permit(:user_id, :title)
  end
end
