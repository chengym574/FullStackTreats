class ProductsController < ApplicationController
    def index
        @products = Product.all 
    end
    
    def show
      @product = Product.find(params[:id])
    end

    def search
      @products = Product.includes(:category)

      if params[:search].present?
        @products = Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      end
      if params[:category].present?
        @products = @products.where(category_id: params[:category])
      end
      
      @products = @products.all.page(params[:page]).per(10)
      @categories = Category.all 
      render 'home/index'
    end
end
