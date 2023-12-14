class ProfileController < ApplicationController
  def edit
    @user = current_user
    @location = @user.location || Location.new 
  end

  def update
    @user = current_user
    @location = @user.location || Location.new 
    if @location.update(location_params) && @user.update(location_id: @location.id)
      redirect_to root_path, notice: 'Profile updated successfully!'
    else
      render :edit
    end
  end

  private

  def location_params
    params.require(:location).permit(:address, :city, :province)
  end
end
