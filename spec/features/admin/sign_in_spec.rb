require 'rails_helper'

feature "Signing in" do
  background do
    create(:admin, email: 'admin@hr.com', password: 'admin123')
  end

  scenario "Signing in with correct credentials" do
    visit '/admin'
    within(".form-inputs") do
      fill_in 'Email', with: 'admin@hr.com'
      fill_in 'Password', with: 'admin123'
    end
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Signing in with wrong credentials" do
    visit '/admin'
    within(".form-inputs") do
      fill_in 'Email', with: 'admin@hr.com'
      fill_in 'Password', with: 'wrong_password'
    end
    click_button 'Sign in'

    expect(page).not_to have_content 'Signed in successfully'
  end
end


# use RSpec syntax
# RSpec.describe "Signing in", type: :feature do

#   before :each do
#     create(:admin, email: 'admin@hr.com', password: 'admin123')
#   end

#   it "Signing in with correct credentials" do
#   visit '/admin'
#     within(".form-inputs") do
#       fill_in 'Email', with: 'admin@hr.com'
#       fill_in 'Password', with: 'admin123'
#     end
#     click_button 'Sign in'

#     expect(page).to have_content 'Signed in successfully'
#   end
# end