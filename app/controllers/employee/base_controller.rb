class Employee::BaseController < ApplicationController
  layout 'employee'
  before_action :authenticate_employee!

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  end
end