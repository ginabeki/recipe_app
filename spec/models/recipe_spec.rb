require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Associations test' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'Validation test' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end
end
