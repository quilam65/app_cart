class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @products = Category.find(params[:id]).products
  end


end
