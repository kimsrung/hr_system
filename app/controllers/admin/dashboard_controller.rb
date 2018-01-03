class Admin::DashboardController < Admin::BaseController
  def index
    @companies = Company.includes(:employers, :employees, :documents).all
  end
end
