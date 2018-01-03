require 'rails_helper'

feature "Employee/Dashboard" do
  background do
    @employee = create(:employee, name: 'Kimsrung', email: 'kimsrung@knit.com', password: 'kimsrung123')
    sign_in @employee
  end

  scenario "Welcome Employee" do
    visit '/employee'

    expect(page).to have_content "HR System"
    expect(page).to have_content "Welcome Employee Kimsrung!"
  end

  scenario "Menu for employee" do
    visit '/employee'

    expect(page).to have_content 'Documents'
    expect(page).to have_content 'Sign Out'
  end

  scenario "List documents" do
    doc1 = create(:document, employee: @employee, company: @employee.company)
    doc2 = create(:document, employee: @employee, company: @employee.company)
    visit "/employee"

    expect(page).to have_content doc1.name
    expect(page).to have_content doc2.name
  end
end