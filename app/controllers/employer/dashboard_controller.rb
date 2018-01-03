class Employer::DashboardController < Employer::BaseController
  def index
    @employees = current_company.employees
    @documents = current_company.documents
  end
end
