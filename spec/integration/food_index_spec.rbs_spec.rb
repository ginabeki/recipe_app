require 'rails_helper'

RSpec.feature 'FoodIndices', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }

  before do
    user.confirm # Confirm the user's email address
    login_as(user) # sign in the user
  end

  describe 'Index page' do
    it 'can see the Food List text on the page.' do
      visit foods_path(user)
      expect(page).to have_content('All Foods')
    end
    it "can click on the 'Add Food' button" do
      visit foods_path(user)
      click_link 'Add Food'
      expect(page).to have_current_path(new_food_path(user))
    end
  end

  describe 'New food page' do
    it 'can add a new food' do
      visit new_food_path(user)

      fill_in 'Name', with: 'Pizza'
      fill_in 'Measurement unit', with: 'Kg'
      fill_in 'Quantity', with: 2
      fill_in 'Price', with: 12

      click_button 'Create Food'

      expect(page).to have_content('All Foods')
    end
  end
end
