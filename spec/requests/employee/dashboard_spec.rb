require 'rails_helper'

RSpec.describe "employee/dashboard#index", type: :request do
  it 'redirect for sign-in' do
    get '/employee'
    assert_response :redirect
    assert_redirected_to new_employee_session_path
  end

  context 'signed-in' do
    before :each do
      @employee = create(:employee)
      sign_in @employee
    end

    it 'gives response success' do
      get '/employee'
      assert_response :success
    end

    it "displays welcome" do
      get "/employee"
      assert_select "h3", "Welcome Employee #{@employee.name}!"
    end

    it "displays document list" do
      doc1 = create(:document, employee: @employee, company: @employee.company)
      doc2 = create(:document, employee: @employee, company: @employee.company)
      get "/employee"
      assert_select "td", doc1.name
      assert_select "td", doc2.name
    end
  end
end