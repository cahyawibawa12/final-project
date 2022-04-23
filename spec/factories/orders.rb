FactoryBot.define do
  factory :order do
    customer_email { "halogigih@gmail.com" }
    total { 10000.0 }
    status { "NEW" }
  end

  factory :invalid_order, parent: :order do
    customer_email { nil }
    total { 10000.0 }
    status { nil }
  end
end
