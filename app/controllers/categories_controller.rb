# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:title).page params[:page]
  end
end
