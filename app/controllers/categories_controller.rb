class CategoriesController < ApplicationController

  def show
    @products = Category.find(params[:id]).products
  end

  def index
    @categories = Category.all

  end
end
