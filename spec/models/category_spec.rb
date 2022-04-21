require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category){
    FactoryBot.create(:category)
  }

  it 'has a valid factory' do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it 'ia valid with a name' do
    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category.name = nil
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  describe 'self#by_letter' do
    context 'with matching letter' do
      it "should return a sorted array of results that match" do
        category1 = FactoryBot.create(:category, name: 'Indonesian Tradisional')        
        category2 = FactoryBot.create(:category, name: 'Main Dish')
        category3 = FactoryBot.create(:category, name: 'Indonesian Modern')
  
        expect(Category.by_letter("I")).to eq([category3, category1])
      end
    end
  end
end
