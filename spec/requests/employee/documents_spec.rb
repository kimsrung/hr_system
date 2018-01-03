require 'rails_helper'

RSpec.describe "employee/documents", type: :request do

  before :each do
    @employee = create(:employee)
    sign_in @employee
  end

  context 'GET' do
    it 'gives response success' do
      get '/employee/documents'
      assert_response :success
    end

    it "displays Welcome header" do
      get "/employee/documents"
      assert_select "h3", "Welcome Employee #{@employee.name}!"
    end

    it "displays document list" do
      create(:document, employee: @employee, company: @employee.company, name: 'Contract A')
      create(:document, employee: @employee, company: @employee.company, name: 'Contract B')
      get "/employee/documents"
      assert_select "td", "Contract A"
      assert_select "td", "Contract B"
    end
  end

  context 'UPDATE' do
    before :each do
      @document = create(:document, employee: @employee, company: @employee.company, name: 'Contract A')
    end

    it 'updates document successfully' do
      expect(@document.submitted_file).to be_blank
      put employee_document_path(@document), params: { document: { submitted_file: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'SampleEmploymentContract.pdf'), 'application/pdf') } }
      expect(@document.reload.submitted_file).to be_present
    end

    it 'fails to update document' do
      put employee_document_path(@document), params: { document: { name: "Contact B" } }
      expect(@document.reload.name).to eq "Contract A"
    end
  end

  context 'SHOW' do
    before :each do
      @document = create(:document, employee: @employee, company: @employee.company, name: 'Contract A')
    end

    it 'shows detail' do
      get "/employee/documents/#{@document.id}"
      expect(response.body).to include(@document.name)
    end
  end
end