class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @products = Category.find(params[:id]).products
  end

  def index
    @categories = Category.all
  end
end
