require 'rails_helper'

RSpec.describe "admin/employers", type: :request do

  before :each do
    @admin = create(:admin)
    sign_in @admin
  end

  context 'GET' do
    it 'gives response success' do
      get '/admin/employers'
      assert_response :success
    end

    it "displays Employer header" do
      get "/admin/employers"
      assert_select "h3", "Employers"
    end

    it "displays employer list" do
      com1 = create(:employer, name: 'Eliot')
      com2 = create(:employer, name: 'Kama')
      get "/admin/employers"
      assert_select "td", "Eliot"
      assert_select "td", "Kama"
    end
  end

  context 'POST' do
    it 'creates new employer successfully' do
      com = create(:company)
      expect {
        post admin_employers_path, params: { employer: { name: "Eliot", email: 'eliot@knit.com', company_id: com.id, password: 'anything' } }
      }.to change{Employer.count}.by(1)
    end

    it 'fails to create new employer' do
      expect {
        post admin_employers_path, params: { employer: { name: nil } }
      }.to change{Employer.count}.by(0)
    end
  end

  context 'UPDATE' do
    before :each do
      @employer = create(:employer, name: 'Kama')
    end

    it 'updates employer successfully' do
      put admin_employer_path(@employer), params: { employer: { name: "Eliot" } }
      expect(@employer.reload.name).to eq "Eliot"
    end

    it 'fails to update employer' do
      put admin_employer_path(@employer), params: { employer: { name: nil } }
      expect(@employer.reload.name).to eq "Kama"
    end
  end

  context 'DELETE' do
    it 'destroy' do
      employer = create(:employer)
      expect {
        delete admin_employer_path(employer)
      }.to change{Employer.count}.by(-1)
    end
  end
end