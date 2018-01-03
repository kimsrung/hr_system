require 'rails_helper'

RSpec.describe "employer/employees", type: :request do

  before :each do
    @employer = create(:employer)
    sign_in @employer
  end

  context 'GET' do
    it 'gives response success' do
      get '/employer/employees'
      assert_response :success
    end

    it "displays Employees header" do
      get "/employer/employees"
      assert_select "h3", "Employees"
    end

    it "displays employee list" do
      com1 = create(:employee, company: @employer.company, name: 'Rotana')
      com2 = create(:employee, company: @employer.company, name: 'Kimsrung')
      get "/employer/employees"
      assert_select "td", "Rotana"
      assert_select "td", "Kimsrung"
    end
  end

  context 'POST' do
    it 'creates new employee successfully' do
      com = @employer.company
      expect {
        post employer_employees_path, params: { employee: { name: "kimsrung", email: 'kimsrung@knit.com', company_id: com.id, password: 'anything' } }
      }.to change{Employee.count}.by(1)
    end

    it 'fails to create new employee' do
      expect {
        post employer_employees_path, params: { employee: { name: nil } }
      }.to change{Employee.count}.by(0)
    end
  end

  context 'UPDATE' do
    before :each do
      @employee = create(:employee, company: @employer.company, name: 'Rotana')
    end

    it 'updates employee successfully' do
      put employer_employee_path(@employee), params: { employee: { name: "Kimsrung" } }
      expect(@employee.reload.name).to eq "Kimsrung"
    end

    it 'fails to update employee' do
      put employer_employee_path(@employee), params: { employee: { name: nil } }
      expect(@employee.reload.name).to eq "Rotana"
    end
  end

  context 'DELETE' do
    it 'destroy' do
      employee = create(:employee, company: @employer.company)
      expect {
        delete employer_employee_path(employee)
      }.to change{Employee.count}.by(-1)
    end
  end
end