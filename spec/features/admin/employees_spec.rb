require 'rails_helper'

feature "Employee" do
  background do
    @admin = create(:admin)
    sign_in @admin
  end

  scenario 'go to employee page' do

    visit '/admin'
    click_link 'Employees'

    expect(page).to have_content 'Employee'
    expect(page).to have_content 'New  Employee'
  end

  scenario 'list exist employees' do
    create(:employee, name: 'Rotana')
    create(:employee, name: 'Kimsrung')

    
    visit '/admin/employees'
    
    expect(page).to have_content "Rotana"
    expect(page).to have_content "Kimsrung"

    # menu for each employee
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'
  end

  scenario 'create new employees' do
    create(:company, name: 'Knit')

    visit '/admin/employees'
    click_link 'New Employee'

    fill_in 'Name', with: 'Kimsrung'
    fill_in 'Email', with: 'kimsrung@knit.com'
    fill_in 'Password', with: 'anything'
    fill_in 'Password confirmation', with: 'anything'
    select "Knit", from: "Company"

    fill_in 'Description', with: 'Front Developer'
    click_button 'Create Employee'  

    expect(page).to have_content 'Employee was successfully created'
    expect(page).to have_content 'Kimsrung'
    expect(page).to have_content 'Knit'
  end

  
  scenario 'Update employee' do
    com = create(:employee, name: 'Rotana')

    visit admin_employees_path

    click_link 'Edit'

    within('.edit_employee') do
      fill_in 'Name', with: 'Kimsrung'
      click_button 'Update Employee'
    end

    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).to have_content 'Kimsrung'
  end


  # scenario 'Destroy employee', js: true do
  #   com = create(:employee, name: 'Rotana')

  #   visit '/admin/employees'

  #   click_link 'Destroy'

  #   page.execute_script 'window.confirm = function () { return true }'

  #   expect(page).to have_content 'Employee was successfully destroyed.'
  #   expect(page).to have_no_content 'Rotana'
  # end

end
