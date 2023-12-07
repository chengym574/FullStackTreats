class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:show_about, :show_contact]
  
  # Show pages
  def show_about
    @about_content = ENV['ABOUT_CONTENT']
  end

  def show_contact
    @contact_content = ENV['CONTACT_CONTENT']
  end

  # Edit pages
  def edit_about
    @about_content = ENV['ABOUT_CONTENT']
  end

  def edit_contact
    @contact_content = ENV['CONTACT_CONTENT']
  end

  # Update pages
  def update_about
    ENV['ABOUT_CONTENT'] = params[:about_content]
    redirect_to pages_about_path, notice: 'About page content updated successfully!'
  end

  def update_contact
    ENV['CONTACT_CONTENT'] = params[:contact_content]
    redirect_to pages_contact_path, notice: 'Contact page content updated successfully!'
  end
end
