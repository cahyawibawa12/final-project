class Order < ApplicationRecord
  has_many :order_detail

  validates :customer_email, presence: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "not valid" }

  validates :total, presence: true
  validates :order_date, presence: true
  validates :status, presence: true
end
