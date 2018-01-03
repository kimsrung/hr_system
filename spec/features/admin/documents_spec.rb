require 'rails_helper'

feature "Document" do
  background do
    @admin = create(:admin)
    sign_in @admin
  end

  scenario 'go to document page' do

    visit '/admin'
    click_link 'Documents'

    expect(page).to have_content 'Document'
    expect(page).to have_content 'New Document'
  end

  scenario 'list exist documents' do
    create(:document, name: 'Contract A')
    create(:document, name: 'Contract B')

    
    visit '/admin/documents'
    
    expect(page).to have_content "Contract A"
    expect(page).to have_content "Contract B"

    # menu for each document
    expect(page).to have_content 'Show'
    expect(page).to have_content 'Edit'
    expect(page).to have_content 'Destroy'
  end

  scenario 'create new documents' do
    create(:company, name: 'Knit')
    create(:employer, name: 'Eliot')
    create(:employee, name: 'Kimsrung')

    visit '/admin/documents'
    click_link 'New Document'

    fill_in 'Name', with: 'Contract A'
    select "Knit", from: "Company"
    select "Eliot", from: "Employer"
    select "Kimsrung", from: "Employee"

    #Todo: assign file


    fill_in 'Description', with: 'Contract for Front Developer'
    click_button 'Create Document'  

    expect(page).to have_content 'Document was successfully created'
    expect(page).to have_content 'Contract A'
    expect(page).to have_content 'Knit'
    expect(page).to have_content 'Eliot'
    expect(page).to have_content 'Kimsrung'
  end

  
  scenario 'Update document' do
    com = create(:document, name: 'Contract A')

    visit admin_documents_path

    click_link 'Edit'

    fill_in 'Name', with: 'Contract B'
    click_button 'Update Document'

    expect(page).to have_content 'Document was successfully updated.'
    expect(page).to have_content 'Contract B'
  end


  # scenario 'Destroy document', js: true do
  #   com = create(:document, name: 'Contract A')

  #   visit '/admin/documents'

  #   click_link 'Destroy'

  #   page.execute_script 'window.confirm = function () { return true }'

  #   expect(page).to have_content 'Document was successfully destroyed.'
  #   expect(page).to have_no_content 'Contract A'
  # end

end