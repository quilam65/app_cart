class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(5)
  end

  def index
    @categories = Category.all.page(params[:page]).per(5)
  end
end
