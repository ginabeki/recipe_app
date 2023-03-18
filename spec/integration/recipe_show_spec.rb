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
 
    it "can click on the 'Add ingredient' button" do
      visit recipe_path(recipe)
      click_button 'Add ingredient'
      expect(page).to have_current_path(ingredients_new_path(recipe))
    end
  end
end
