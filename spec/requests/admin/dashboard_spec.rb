require 'rails_helper'

RSpec.describe "admin/dashboard#index", type: :request do
  it 'redirect for sign-in' do
    get '/admin'
    assert_response :redirect
    assert_redirected_to new_admin_session_path
  end

  context 'signed-in' do
    before :each do
      @admin = create(:admin)
      sign_in @admin
    end

    it 'gives response success' do
      get '/admin'
      assert_response :success
    end

    it "displays HR System" do
      get "/admin"
      assert_select "b", "HR System"
    end

    it "displays company list" do
      com1 = create(:company, name: "Knit")
      com2 = create(:company, name: "Yoolk")
      get "/admin"
      assert_select "h2", "Company #{com1.name}"
      assert_select "h2", "Company #{com2.name}"
    end
  end
end