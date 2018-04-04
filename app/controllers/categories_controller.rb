class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page])
  end

  def index
    @categories = Category.all.page(params[:page])
  end
end
