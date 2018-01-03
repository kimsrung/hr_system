require 'rails_helper'

RSpec.describe "home#index", type: :request do
  it 'gives response success' do
    get "/"
    assert_response :success
  end

  it "displays panels for Admin, Employer and Employee" do
    get "/"
    assert_select "a[href='#{admin_root_path}']", "Admin Panel"
    assert_select "a[href='#{employer_root_path}']", "Employer Panel"
    assert_select "a[href='#{employee_root_path}']", "Employee Panel"
  end
end