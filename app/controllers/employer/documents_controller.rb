class  Employer::DocumentsController < Employer::BaseController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :download_assigned_file, :download_submitted_file]

  # GET /documents
  def index
    @documents = current_company.documents
  end

  # GET /documents/1
  def show
  end

  # GET /documents/new
  def new
    @document = current_employer.documents.new(company: current_company)
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  def create
    @document = current_employer.documents.new(document_params)
    @document.company = current_company

    if @document.save
      redirect_to [:employer, @document], notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /documents/1
  def update
    if @document.update(document_params)
      redirect_to [:employer, @document], notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /documents/1
  def destroy
    @document.destroy
    redirect_to employer_documents_url, notice: 'Document was successfully destroyed.'
  end

  def download_assigned_file
    send_file(@document.assigned_file.path,
        disposition: 'attachment',
        filename: "#{@document.name}.#{@document.assigned_file.file.extension}",
        url_based_filename: true)
  end

  def download_submitted_file
    send_file(@document.submitted_file.path,
        disposition: 'attachment',
        filename: "#{@document.name}_signed.#{@document.submitted_file.file.extension}",
        url_based_filename: true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = current_company.documents.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :description, :assigned_file, :employee_id)
    end
end
