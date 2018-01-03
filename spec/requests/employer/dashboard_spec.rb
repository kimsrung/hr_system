require 'rails_helper'

RSpec.describe "employer/dashboard#index", type: :request do
  it 'redirect for sign-in' do
    get '/employer'
    assert_response :redirect
    assert_redirected_to new_employer_session_path
  end

  context 'signed-in' do
    before :each do
      @employer = create(:employer)
      sign_in @employer
    end

    it 'gives response success' do
      get '/employer'
      assert_response :success
    end

    it "displays welcome" do
      get "/employer"
      assert_select "h3", "Welcome #{@employer.name}!"
    end

    it "displays document list" do
      doc1 = create(:document, company: @employer.company)
      doc2 = create(:document, company: @employer.company)
      get "/employer"
      assert_select "td", doc1.name
      assert_select "td", doc2.name
    end
  end
end