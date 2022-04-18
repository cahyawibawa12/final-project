require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "is valid with a name and a description" do
    menu = Menu.new(
      name: "Nasi Goreng Ayam",
      description: "Fried rice with chicken",
      price: 10000.0
    )

    expect(menu).to be_valid
  end

  it "is invalid without name" do
    menu = Menu.new(
      name: nil,
      description: "Fried rice with chicken",
      price: 10000.0
    )
    
    menu.valid?
    
    expect(menu.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    menu1 = Menu.create(
      name: "Nasi Goreng Ayam",
      description: "Fried rice with chicken",
      price: 10000.0
    )
    
    menu2 = Menu.new(
      name: "Nasi Goreng Ayam",
      description: "Fried rice with chicken",
      price: 10000.0
    )
    menu2.valid?

    expect(menu2.errors[:name]).to include("has already been taken")
  end

  it "is invalid without price" do
    menu = Menu.new(
      name: "Nasi Goreng Ayam",
      description: "Fried rice with chicken",
      price: nil
    )
    
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
    menu = Menu.new(
      name: "Nasi Goreng Ayam",
      description: nil,
      price: 10000.0
    )
    
    menu.valid?
    
    expect(menu.errors[:description]).to include("can't be blank")
  end

  describe 'self#by_letter' do
    it "should return a sorted array of results that match" do
      menu1 = Menu.create(
        name: "Nasi Goreng Ayam",
        description: "Fried rice with chicken",
        price: 10000.0
      )

      menu2 = Menu.create(
        name: "Soto Ayam",
        description: "Traditional Indonesian dish which uses ingredients such as chicken, lontong, noodles, and rice vermicelli.",
        price: 8000.0
      )

      menu3 = Menu.create(
        name: "Nasi Goreng Telor",
        description: "Fried rice with Egg",
        price: 8000.0
      )

      expect(Menu.by_letter("N")).to eq([menu1, menu3])
    end
  end
end
