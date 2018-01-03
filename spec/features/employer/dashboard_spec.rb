require 'rails_helper'

feature "Employer/Dashboard" do
  background do
    @employer = create(:employer, name: 'Eliot', email: 'eloit@knit.com', password: 'eloit123')
    sign_in @employer
  end

  scenario "Welcome Employer" do
    visit '/employer'

    expect(page).to have_content "HR System"
    expect(page).to have_content "Eliot"
  end

  scenario "Menu for employer" do
    visit '/employer'

    expect(page).to have_content 'Employees'
    expect(page).to have_content 'Documents'
    expect(page).to have_content 'Sign Out'
  end

  scenario "List employees" do
    emp1 = create(:employee, company: @employer.company)
    emp2 = create(:employee, company: @employer.company)

    visit '/employer'

    expect(page).to have_content emp1.name
    expect(page).to have_content emp2.name
  end

  scenario "List documents" do
    doc1 = create(:document, company: @employer.company)
    doc2 = create(:document, company: @employer.company)
    visit "/employer"

    expect(page).to have_content doc1.name
    expect(page).to have_content doc2.name
  end
end