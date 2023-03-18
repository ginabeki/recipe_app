require 'rails_helper'
RSpec.feature 'RecipeShows', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let!(:food) { FactoryBot.create(:food, user:) }
  before do
    user.confirm # Confirm the user's email address
    login_as(user) # sign in the user
  end
  describe 'Show page' do
    it 'can see the Food List text on the page.' do
      visit recipe_path(user, recipe)
      expect(page).to have_content('Public')
    end
    it "can click on the 'Add ingredient' button" do
      visit recipe_path(user, recipe)
      click_button 'Add ingredient'
      expect(page).to have_current_path(ingredients_new_path(recipe))
    end
    it "can click on the 'Generate shopping list' button" do
      visit "/general_shopping_list/#{recipe.id}"
      click_button 'Generate shopping list'
      expect(page).to have_current_path("/general_shopping_list/#{recipe.id}")
    end
  end
end
