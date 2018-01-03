require 'rails_helper'

RSpec.describe "employer/documents", type: :request do

  before :each do
    @employer = create(:employer)
    sign_in @employer
  end

  context 'GET' do
    it 'gives response success' do
      get '/employer/documents'
      assert_response :success
    end

    it "displays Document header" do
      get "/employer/documents"
      assert_select "h3", "Documents"
    end

    it "displays document list" do
      create(:document, company: @employer.company, name: 'Contract A')
      create(:document, company: @employer.company, name: 'Contract B')
      get "/employer/documents"
      assert_select "td", "Contract A"
      assert_select "td", "Contract B"
    end
  end

  context 'POST' do
    it 'creates new document successfully' do
      employee = create(:employee, company: @employer.company)
      expect {
        post employer_documents_path, params: { document: { name: "Contract A", employee_id: employee.id, assigned_file: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'SampleEmploymentContract.pdf'), 'application/pdf') } }
      }.to change{Document.count}.by(1)
    end

    it 'fails to create new document' do
      expect {
        post employer_documents_path, params: { document: { name: nil } }
      }.to change{Document.count}.by(0)
    end
  end

  context 'UPDATE' do
    before :each do
      @document = create(:document, company: @employer.company, name: 'Contract A')
    end

    it 'updates document successfully' do
      put employer_document_path(@document), params: { document: { name: "Contract B" } }
      expect(@document.reload.name).to eq "Contract B"
    end

    it 'fails to update document' do
      put employer_document_path(@document), params: { document: { name: nil } }
      expect(@document.reload.name).to eq "Contract A"
    end
  end

  context 'DELETE' do
    it 'destroy' do
      document = create(:document, company: @employer.company)
      expect {
        delete employer_document_path(document)
      }.to change{Document.count}.by(-1)
    end
  end
end