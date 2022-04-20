require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:category) do
    return FactoryBot.create(:category)
  end
  subject(:menu) do
    return FactoryBot.create(:menu, category: category)
  end
  
  it "has a valid factory" do
    expect(FactoryBot.build(:menu)).to be_valid
  end
  
  it "is valid with a name and a description" do
   expect(menu).to be_valid
  end

  it 'is invalid without a category' do
    menu.category = nil
    menu.valid?
    expect(menu.errors[:category]).to include('must exist')
  end

  it "is invalid without name" do
    menu = FactoryBot.build(:menu, name: nil)
    menu.valid?
    expect(menu.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    menu1 = FactoryBot.create(:menu, name: 'Nasi Goreng Ayam')
    menu2 = FactoryBot.build(:menu, name: 'Nasi Goreng Ayam')

    menu2.valid?
    expect(menu2.errors[:name]).to include("has already been taken")
  end

  it "is invalid without price" do
    menu = FactoryBot.build(:menu, price: nil)
    menu.valid?
    expect(menu.errors[:price]).to include("can't be blank")
  end

  it "is valid with price greater than or equals to 0.01" do
    menu = Menu.new(
      name: "Nasi Goreng Ayam",
      description: "Fried rice with chicken",
      price: 0.001
    )

    menu.valid?
    
    expect(menu.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it "is invalid without description" do
    menu = FactoryBot.build(:menu, description: nil)
    menu.valid?
    expect(menu.errors[:description]).to include("can't be blank")
  end

  describe 'self#by_letter' do
    context 'with matching letter' do
      it "should return a sorted array of results that match" do
        menu1 = FactoryBot.create(:menu, name: 'Nasi Goreng Ayam')
        menu2 = FactoryBot.create(:menu, name: 'Ketoprak')
        menu3 = FactoryBot.create(:menu, name: 'Nasi Goreng Telor')
  
        expect(Menu.by_letter("N")).to eq([menu1, menu3])
      end
    end
  end
  
   describe 'self#by_category' do
    it 'should return menus that has the category' do
      new_category = FactoryBot.build(:category, name: 'test_test')
      menu2 = FactoryBot.create(:menu, name: 'Nasi Goreng Ayam', category: new_category)

      expect(Menu.by_category(category.name)).to eq([menu])
      expect(Menu.by_category(new_category.name)).to eq([menu2])
    end
  end
end
