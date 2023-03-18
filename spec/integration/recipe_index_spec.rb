require 'rails_helper'

RSpec.feature 'FoodIndices', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:recipe, user:) }

  before do
    user.confirm # Confirm the user's email address
    login_as(user) # sign in the user
  end

  describe 'Index page' do
    it 'can see the Recipe List text on the page.' do
      visit recipes_path(user)
      expect(page).to have_content('All Recipes')
    end
    it "can click on the 'Add Recipe' button" do
      visit recipes_path(user)
      click_link 'Add Recipe'
      expect(page).to have_current_path(new_recipe_path(user))
    end
  end

  describe 'New Recipe page' do
    it 'can add a new recipe' do
      visit new_recipe_path(user)

      fill_in 'Name', with: 'Pizza'
      fill_in 'Preparation time(minutes)', with: 25
      fill_in 'Cooking time(minutes)', with: 30
      fill_in 'Description', with: 'Desc'

      click_button 'Create Recipe'

      expect(page).to have_content('All Recipes')
    end
  end
end
