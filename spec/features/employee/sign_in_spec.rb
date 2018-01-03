require 'rails_helper'

feature "Signing in" do
  background do
    create(:employee, email: 'kimsrung@knit.com', password: 'kimsrung123')
  end

  scenario "Signing in with correct credentials" do
    visit '/employee'
    within(".form-inputs") do
      fill_in 'Email', with: 'kimsrung@knit.com'
      fill_in 'Password', with: 'kimsrung123'
    end
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Signing in with wrong credentials" do
    visit '/employee'
    within(".form-inputs") do
      fill_in 'Email', with: 'kimsrung@knit.com'
      fill_in 'Password', with: 'wrong_password'
    end
    click_button 'Sign in'

    expect(page).not_to have_content 'Signed in successfully'
  end
end