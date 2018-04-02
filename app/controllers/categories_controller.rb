
class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @products = Category.find(params[:id]).products.page(params[:page]).per(1)
  end

  def index
    @categories = Category.all.page(params[:page]).per(1)
  end
end
