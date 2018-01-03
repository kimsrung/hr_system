require 'rails_helper'

RSpec.describe "admin/employees", type: :request do

  before :each do
    @admin = create(:admin)
    sign_in @admin
  end

  context 'GET' do
    it 'gives response success' do
      get '/admin/employees'
      assert_response :success
    end

    it "displays Employee header" do
      get "/admin/employees"
      assert_select "h3", "Employees"
    end

    it "displays employee list" do
      com1 = create(:employee, name: 'Rotana')
      com2 = create(:employee, name: 'Kimsrung')
      get "/admin/employees"
      assert_select "td", "Rotana"
      assert_select "td", "Kimsrung"
    end
  end

  context 'POST' do
    it 'creates new employee successfully' do
      com = create(:company)
      expect {
        post admin_employees_path, params: { employee: { name: "kimsrung", email: 'kimsrung@knit.com', company_id: com.id, password: 'anything' } }
      }.to change{Employee.count}.by(1)
    end

    it 'fails to create new employee' do
      expect {
        post admin_employees_path, params: { employee: { name: nil } }
      }.to change{Employee.count}.by(0)
    end
  end

  context 'UPDATE' do
    before :each do
      @employee = create(:employee, name: 'Rotana')
    end

    it 'updates employee successfully' do
      put admin_employee_path(@employee), params: { employee: { name: "Kimsrung" } }
      expect(@employee.reload.name).to eq "Kimsrung"
    end

    it 'fails to update employee' do
      put admin_employee_path(@employee), params: { employee: { name: nil } }
      expect(@employee.reload.name).to eq "Rotana"
    end
  end

  context 'DELETE' do
    it 'destroy' do
      employee = create(:employee)
      expect {
        delete admin_employee_path(employee)
      }.to change{Employee.count}.by(-1)
    end
  end
end