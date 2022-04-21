FactoryBot.define do
  factory :order_detail do
    price { 10000.0 }
    qty { 1 }
    sub_total { 10000.0 }
    association :menu, factory: :menu
    association :order, factory: :order
  end

  factory :invalid_oder_detail, parent: :order_detail do
    price { 10000.0 }
    qty { nil }
    sub_total { 10000.0 }
    association :menu, factory: :menu
    association :order, factory: :order
  end
end
