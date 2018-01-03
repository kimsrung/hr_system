require 'rails_helper'

feature "Employer" do
  background do
    @admin = create(:admin)
    sign_in @admin
  end

  scenario 'go to employer page' do

    visit '/admin'
    click_link 'Employers'

    expect(page).to have_content 'Employer'
    expect(page).to have_content 'New  Employer'
  end

  scenario 'list exist employers' do
    create(:employer, name: 'Eliot')
    create(:employer, name: 'Kama')

    
    visit '/admin/employers'
    
    expect(page).to have_content "Eliot"
    expect(page).to have_content "Kama"

    # menu for each employer
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'
  end

  scenario 'create new employers' do
    create(:company, name: 'Knit')

    visit '/admin/employers'
    click_link 'New Employer'

    fill_in 'Name', with: 'Eliot'
    fill_in 'Email', with: 'eliot@knit.com'
    fill_in 'Password', with: 'anything'
    fill_in 'Password confirmation', with: 'anything'
    select "Knit", from: "Company"

    fill_in 'Description', with: 'HR Service'
    click_button 'Create Employer'  

    expect(page).to have_content 'Employer was successfully created'
    expect(page).to have_content 'Eliot'
    expect(page).to have_content 'Knit'
  end

  
  scenario 'Update employer' do
    com = create(:employer, name: 'Kama')

    visit admin_employers_path

    click_link 'Edit'

    within('.edit_employer') do
      fill_in 'Name', with: 'Eliot'
      click_button 'Update Employer'
    end

    expect(page).to have_content 'Employer was successfully updated.'
    expect(page).to have_content 'Eliot'
  end


  # scenario 'Destroy employer', js: true do
  #   com = create(:employer, name: 'Bi-Kay')

  #   visit '/admin/employers'

  #   click_link 'Destroy'

  #   page.execute_script 'window.confirm = function () { return true }'

  #   expect(page).to have_content 'employer was successfully destroyed.'
  #   expect(page).to have_no_content 'Bi-Kay'
  # end

end
