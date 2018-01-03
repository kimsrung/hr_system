class Admin::EmployersController < Admin::BaseController
  before_action :set_employer, only: [:show, :edit, :update, :destroy]

  # GET /employers
  def index
    @employers = Employer.all
  end

  # GET /employers/1
  def show
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  def create
    @employer = Employer.new(employer_params)

    if @employer.save
      redirect_to admin_employer_path(@employer), notice: 'Employer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /employers/1
  def update
    if @employer.update(employer_params)
      redirect_to admin_employer_path(@employer), notice: 'Employer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /employers/1
  def destroy
    @employer.destroy
    redirect_to admin_employers_url, notice: 'Employer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employer
      @employer = Employer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employer_params
      params.require(:employer).permit(:name, :description, :company_id, :email, :password)
    end
end
