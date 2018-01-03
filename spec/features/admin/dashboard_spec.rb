require 'rails_helper'

feature "Dashboard" do
  background do
    @admin = create(:admin)
    sign_in @admin
  end

  scenario "Welcome Admin" do
    visit '/admin'

    expect(page).to have_content "HR System"
    expect(page).to have_content @admin.email
  end

  scenario "Menu for Admin" do
    visit '/admin'

    expect(page).to have_content 'Company'
    expect(page).to have_content 'Employers'
    expect(page).to have_content 'Employees'
    expect(page).to have_content 'Documents'
    expect(page).to have_content 'Sign Out'
  end

  scenario "List companies" do
    com1 = create(:company, name: "Knit")
    com2 = create(:company, name: "Yoolk")

    visit '/admin'

    expect(page).to have_content "Company #{com1.name}"
    expect(page).to have_content "Company #{com2.name}"
  end
end