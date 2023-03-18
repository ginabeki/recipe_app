require 'rails_helper'
describe '/public_recipes', type: :feature do
  scenario 'guest can see but not view a page' do
    visit '/public_recipes'
    expect(page).to have_text('Public Recipes')
  end
end
