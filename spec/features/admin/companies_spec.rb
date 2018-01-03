require 'rails_helper'

feature "Company" do
  background do
    @admin = create(:admin)
    sign_in @admin
  end

  scenario 'go to company page' do

    visit '/admin'
    click_link 'Company'

    expect(page).to have_content 'Company'
    expect(page).to have_content 'New Company'
  end

  scenario 'list exist companies' do
    com1 = create(:company, name: 'Knit')
    com2 = create(:company, name: 'Yoolk')

    visit '/admin'
    click_link 'Company'

    expect(page).to have_content "Knit"
    expect(page).to have_content "Yoolk"

    # menu for each company
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'
  end

  scenario 'create new companies' do
    visit '/admin/companies'
    click_link 'New Company'

    fill_in 'Name', with: 'Bi-Kay'
    fill_in 'Description', with: 'IT Solution'
    click_button 'Create Company'

    expect(page).to have_content 'Company was successfully created'
    expect(page).to have_content 'Bi-Kay'
    expect(page).to have_content 'IT Solution'
  end

  scenario 'Show error when missing name when creating new companies' do
    visit '/admin/companies'
    click_link 'New Company'

    fill_in 'Description', with: 'IT Solution'
    click_button 'Create Company'


    expect(page).to have_content 'New Company'
    expect(page).to have_content "can't be blank"
  end

  scenario 'Update company' do
    com = create(:company, name: 'Bi-Kay')

    visit admin_companies_path

    click_link 'Edit'

    within('.edit_company') do
      fill_in 'Name', with: 'Knit'
      click_button 'Update Company'
    end

    expect(page).to have_content 'Company was successfully updated.'
    expect(page).to have_content 'Knit'
  end


  # scenario 'Destroy company', js: true do
  #   com = create(:company, name: 'Bi-Kay')

  #   visit '/admin/companies'

  #   click_link 'Destroy'

  #   page.execute_script 'window.confirm = function () { return true }'

  #   expect(page).to have_content 'Company was successfully destroyed.'
  #   expect(page).to have_no_content 'Bi-Kay'
  # end
end