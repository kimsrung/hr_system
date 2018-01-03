require 'rails_helper'

RSpec.describe "admin/companies", type: :request do

  before :each do
    @admin = create(:admin)
    sign_in @admin
  end

  context 'GET' do
    it 'gives response success' do
      get '/admin/companies'
      assert_response :success
    end

    it "displays Company" do
      get "/admin/companies"
      assert_select "h3", "Companies"
    end

    it "displays company list" do
      com1 = create(:company, name: 'Knit')
      com2 = create(:company, name: 'Yoolk')
      get "/admin/companies"
      assert_select "td", "Knit"
      assert_select "td", "Yoolk"
    end
  end

  context 'POST' do
    it 'creates new company successfully' do
      expect {
        post admin_companies_path, params: { company: { name: "Bi-Kay" } }
      }.to change{Company.count}.by(1)
    end

    it 'fails to create new company' do
      expect {
        post admin_companies_path, params: { company: { name: nil } }
      }.to change{Company.count}.by(0)
    end
  end

  context 'UPDATE' do
    before :each do
      @com = create(:company, name: 'Bi-Kay')
    end

    it 'updates company successfully' do
      put admin_company_path(@com), params: { company: { name: "Knit" } }
      expect(@com.reload.name).to eq "Knit"
    end

    it 'fails to update company' do
      put admin_company_path(@com), params: { company: { name: nil } }
      expect(@com.reload.name).to eq "Bi-Kay"
    end
  end

  context 'DELETE' do
    it 'destroy' do
      com = create(:company)
      expect {
        delete admin_company_path(com)
      }.to change{Company.count}.by(-1)
    end
  end
end