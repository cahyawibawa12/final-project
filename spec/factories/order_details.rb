FactoryBot.define do
  factory :order_detail do
    price { 1.5 }
    qty { 1 }
    sub_total { 1.5 }
  end
end
