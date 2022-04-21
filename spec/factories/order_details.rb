FactoryBot.define do
  factory :order_detail do
    price { 10000.0 }
    qty { 1 }
    sub_total { 10000.0 }
    association :menu
    association :order
  end

  factory :invalid_order_detail, parent: :order_detail do
    price { 10000.0 }
    qty { nil }
    sub_total { 10000.0 }
    association :menu
    association :order
  end
end
