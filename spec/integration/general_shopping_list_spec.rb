require 'rails_helper'
describe '/general_shopping_list/:id', type: :feature do
  scenario 'can see gerenal shopping list' do
    visit '/general_shopping_list/:id'
    expect(page).to have_text('Shopping List')
  end
end
