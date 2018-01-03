require 'rails_helper'

RSpec.describe "admin/documents", type: :request do

  before :each do
    @admin = create(:admin)
    sign_in @admin
  end

  context 'GET' do
    it 'gives response success' do
      get '/admin/documents'
      assert_response :success
    end

    it "displays Document header" do
      get "/admin/documents"
      assert_select "h3", "Documents"
    end

    it "displays document list" do
      com1 = create(:document, name: 'Contract A')
      com2 = create(:document, name: 'Contract B')
      get "/admin/documents"
      assert_select "td", "Contract A"
      assert_select "td", "Contract B"
    end
  end

  context 'POST' do
    it 'creates new document successfully' do
      com = create(:company)
      employer = create(:employer)
      employee = create(:employee)
      expect {
        post admin_documents_path, params: { document: { name: "Contract A", company_id: com.id, employer_id: employer.id, employee_id: employee.id, assigned_file: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'SampleEmploymentContract.pdf'), 'application/pdf') } }
      }.to change{Document.count}.by(1)
    end

    it 'fails to create new document' do
      expect {
        post admin_documents_path, params: { document: { name: nil } }
      }.to change{Document.count}.by(0)
    end
  end

  context 'UPDATE' do
    before :each do
      @document = create(:document, name: 'Contract A')
    end

    it 'updates document successfully' do
      put admin_document_path(@document), params: { document: { name: "Contract B" } }
      expect(@document.reload.name).to eq "Contract B"
    end

    it 'fails to update document' do
      put admin_document_path(@document), params: { document: { name: nil } }
      expect(@document.reload.name).to eq "Contract A"
    end
  end

  context 'DELETE' do
    it 'destroy' do
      document = create(:document)
      expect {
        delete admin_document_path(document)
      }.to change{Document.count}.by(-1)
    end
  end
end