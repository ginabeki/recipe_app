require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'Associations test' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'Validation test' do
    it { should validate_presence_of(:quantity) }
  end
end
