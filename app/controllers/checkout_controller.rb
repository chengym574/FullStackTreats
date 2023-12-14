class CheckoutController < ApplicationController
  def update_address
    @user = current_user
    @location = @user.location || Location.new 

    if @location.update(location_params)
      redirect_to checkout_checkout_path, notice: 'Address updated successfully!'
    else
      render :checkout
    end
  end

  def confirm_order
    user_location = current_user.location

    if user_location&.address.blank? || user_location&.city.blank? || user_location&.province.blank?
      flash[:alert] = 'Please provide shipping address information to confirm the order.'
      redirect_to checkout_checkout_path
      return
    else
      order = Order.create!(
      user_id: current_user.id,
      status: 'In Progress',
      total: session[:order_total]
      )

      session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)

      OrderItem.create!(
          order_id: order.id,
          product_id: product.id,
          quantity: quantity,
          price: product.price
      )
      end

      session[:cart] = {}
      session[:order_total] = nil
        
      redirect_to order_confirmed_path, notice: 'Order placed successfully!'
    end
  end

  def checkout
    @cart_items = session[:cart].map do |product_id, quantity|
      product = Product.find(product_id)
      { product: product, quantity: quantity }
    end

    @user_location = current_user.location
    @subtotal = calculate_subtotal(@cart_items)
    @gst = calculate_gst(@subtotal, @user_location.province)
    @pst = calculate_pst(@subtotal, @user_location.province)
    @hst = calculate_hst(@subtotal, @user_location.province)
    @total = calculate_total(@subtotal, @gst, @pst, @hst)
    session[:order_total] = @total

    render 'checkout/checkout'
  end

  private  

  def calculate_subtotal(cart_items)
    cart_items.sum { |item| item[:product].price * item[:quantity] }
  end

  def calculate_pst(subtotal, province)
    case province
    when 'British Columbia', 'Manitoba'
    subtotal * 0.07 
    when 'Quebec'
    subtotal * 0.09975 
    when 'Saskatchewan'
    subtotal * 0.06 
    else
    0
    end
  end

  def calculate_gst(subtotal, province)
    case province
    when 'Alberta', 'British Columbia', 'Manitoba', 'Northwest Territories', 'Nunavut', 'Quebec', 'Saskatchewan', 'Yukon'
    subtotal * 0.05 
    else
    0
    end
  end

  def calculate_hst(subtotal, province)
    case province
    when 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Prince Edward Island'
    subtotal * 0.15 
    when 'Ontario'
    subtotal * 0.13 
    else
    0
    end
  end

  def calculate_total(subtotal, pst, gst, hst)
    subtotal + pst + gst + hst
  end

  def location_params
    params.require(:location).permit(:address, :city, :province)
  end
end