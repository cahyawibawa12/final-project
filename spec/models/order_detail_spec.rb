require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  
  it "is valid order" do
    expect(FactoryBot.build(:order_detail)).to be_valid
  end

  it "is invalid with a price" do
    order_detail = OrderDetail.create(
      order_id: 1,
      menu_id: 1,
      price: nil,
      qty: 1,
      sub_total: 10000.0
    )

    order_detail.valid?

    expect(order_detail.errors[:price]).to include("can't be blank")
  end

  it "is invalid with a qty" do
    order_detail = OrderDetail.create(
      order_id: 1,
      menu_id: 1,
      price: 10000.0,
      qty: nil,
      sub_total: 10000.0
    )

    order_detail.valid?

    expect(order_detail.errors[:qty]).to include("can't be blank")
  end 
  
  it "is invalid with a sub_total" do
    order_detail = OrderDetail.create(
      order_id: 1,
      menu_id: 1,
      price: 10000.0,
      qty: nil,
      sub_total: nil
    )

    order_detail.valid?

    expect(order_detail.errors[:sub_total]).to include("can't be blank")
  end 
end
