class Employer::BaseController < ApplicationController
  layout 'employer'
  before_action :authenticate_employer!


  def current_company
    @current_company ||= current_employer.company
  end
  helper_method :current_company

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  end
end