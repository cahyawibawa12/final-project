require 'rails_helper'

RSpec.describe Menu, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:menu)).to be_valid
  end
  
  it "is valid with a name and a description" do
   expect(FactoryBot.build(:menu)).to be_valid
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
        menu2 = FactoryBot.create(:menu, name: 'Soto Ayam')
        menu3 = FactoryBot.create(:menu, name: 'Nasi Goreng Telor')
  
        expect(Menu.by_letter("N")).to eq([menu1, menu3])
      end
    end
  end
end
