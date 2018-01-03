class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource


  protected

  def check_signed_in!
    if admin_signed_in? && !current_admin.try(:confirmed_at).blank?
      redirect_to admin_root_path
    end
  end

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    elsif devise_controller? && resource_name == :employer
      "employer"
    elsif devise_controller? && resource_name == :employee
      "employee"
    else
      "application"
    end
  end
end
