class HistoriesController < ApplicationController

  def index
   @carts = current_user.carts.where(status: true).page(params[:page])
  end

  def show
    @cart = Cart.find(params[:id])
  end

end
