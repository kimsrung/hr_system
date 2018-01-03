require 'rails_helper'

RSpec.describe "home", type: :feature do

  it "displays panels for Admin, Employer and Employee" do
    visit "/"
    expect(page).to have_content "Admin Panel"
    expect(page).to have_content "Employer Panel"
    expect(page).to have_content "Employee Panel"
  end
end