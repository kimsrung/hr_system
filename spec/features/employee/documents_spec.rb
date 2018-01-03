require 'rails_helper'

feature "Employee/Document" do
  background do
    @employee = create(:employee)
    sign_in @employee
  end

  scenario 'go to document page' do

    visit '/employee'
    click_link 'Documents'

    expect(page).to have_content "Welcome Employee #{@employee.name}!"
  end

  scenario 'list exist documents' do
    create(:document, employee: @employee, company: @employee.company, name: 'Contract A')
    create(:document, employee: @employee, company: @employee.company, name: 'Contract B')

    visit '/employee/documents'

    expect(page).to have_content "Contract A"
    expect(page).to have_content "Contract B"

    # menu for each document
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_no_content 'Destroy'
  end

  scenario 'Update document' do
    com = create(:document, employee: @employee, company: @employee.company, name: 'Contract A')

    visit employee_documents_path

    click_link 'Edit'

    #Todo: upload file
    click_button 'Update Document'

    expect(page).to have_content 'Document was successfully updated.'
    # expect(page) new file.
  end
end