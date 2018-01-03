require 'rails_helper'

RSpec.describe "home", type: :feature do

  it "displays panels for Admin, Employer and Employee" do
    visit "/"
    expect(page).to have_content "Go to Admin Panel"
    expect(page).to have_content "Go to Employer Panel"
    expect(page).to have_content "Go to Employee Panel"
  end
end