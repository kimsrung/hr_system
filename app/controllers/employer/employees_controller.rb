class  Employer::EmployeesController < Employer::BaseController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  def index
    @employees = current_company.employees
  end

  # GET /employees/1
  def show
  end

  # GET /employees/new
  def new
    @employee = current_company.employees.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  def create
    @employee = current_company.employees.new(employee_params)

    if @employee.save
      redirect_to [:employer, @employee], notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      redirect_to [:employer, @employee], notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    redirect_to employer_employees_path, notice: 'Employee was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = current_company.employees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :description, :email, :company_id)
    end
end
