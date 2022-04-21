require 'rails_helper'

RSpec.describe Order, type: :model do

  it "is valid order" do
    order = Order.create(
      customer_email: "halogigih@gmail.com",
      total: 10000.0,
      order_date: "22/04/2022",
      status: "NEW"
    )

    expect(order).to be_valid
  end

  
  it "is invalid with a customer_email" do
    order = Order.create(
      customer_email: nil,
      total: 10000.0,
      order_date: "22/04/2022",
      status: "NEW"
    )

    order.valid?

    expect(order.errors[:customer_email]).to include("can't be blank")
  end

  it "is invalid with a total" do
    order = Order.create(
      customer_email: "halogigih@gmail.com",
      total: nil,
      order_date: "22/04/2022",
      status: "NEW"
    )

    order.valid?

    expect(order.errors[:total]).to include("can't be blank")
  end

  it "is invalid with a order_date" do
    order = Order.create(
      customer_email: "halogigih@gamil.com",
      total: 10000.0,
      order_date: nil,
      status: "NEW"
    )

    order.valid?

    expect(order.errors[:order_date]).to include("can't be blank")
  end

  it "is invalid with a customer_email" do
    order = Order.create(
      customer_email: "halogigih@gmail.com",
      total: 10000.0,
      order_date: "22/04/2022",
      status: nil
    )

    order.valid?

    expect(order.errors[:status]).to include("can't be blank")
  end  
end
