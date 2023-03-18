require 'rails_helper'
describe '/public_recipes', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  scenario 'user can see and view a page' do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
    FactoryBot.create(:recipe, public: true)
    FactoryBot.create(:recipe, public: false)
    visit '/public_recipes'
    expect(page).to have_text('Public Recipes')
  end
end
