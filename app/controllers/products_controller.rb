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

    def new
      @product = Product.new
    end
  
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to root_path, notice: 'Product created successfully'
      else
        render :new
      end
    end
  
    def edit
      @product = Product.find(params[:id])
    end
  
    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to root_path, notice: 'Product updated successfully'
      else
        render :edit
      end
    end
  
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to root_path, notice: 'Product deleted successfully'
    end
  
    private
  
    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
end
