FactoryBot.define do
  factory :order do
    customer_email { "MyString" }
    total { 1.5 }
  end
end
