require 'rails_helper'

feature "Signing in" do
  background do
    create(:employer, name: 'Eliot', email: 'eloit@knit.com', password: 'eloit123')
  end

  scenario "Signing in with correct credentials" do
    visit '/employer'
    within(".form-inputs") do
      fill_in 'Email', with: 'eloit@knit.com'
      fill_in 'Password', with: 'eloit123'
    end
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Signing in with wrong credentials" do
    visit '/employer'
    within(".form-inputs") do
      fill_in 'Email', with: 'eloit@knit.com'
      fill_in 'Password', with: 'wrong_password'
    end
    click_button 'Sign in'

    expect(page).not_to have_content 'Signed in successfully'
  end
end