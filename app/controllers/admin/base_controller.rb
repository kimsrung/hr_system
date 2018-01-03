class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  end
end