class CartController < ApplicationController
  def add_to_cart
    product_id = params[:id]
    product = Product.find(product_id)

    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    
    redirect_to root_path, notice: 'Product added to cart'
  end

  def update_quantity
    product_id = params[:id]
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity if session[:cart].key?(product_id)
    redirect_to cart_path, notice: 'Quantity updated'
  end

  def remove_item
    product_id = params[:id]
    session[:cart].delete(product_id) if session[:cart].key?(product_id)
    redirect_to cart_path, notice: 'Item removed from cart'
  end

  def show_cart
  end
end
