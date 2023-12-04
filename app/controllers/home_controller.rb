class HomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.page(params[:page]).per(20)
  end
end
