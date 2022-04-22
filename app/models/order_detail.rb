class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :menu

  validates :price, presence: true
  validates :qty, presence: true
  validates :sub_total, presence: true

  def sum_subtotal
    self.sub_total = self.price * self.qty
  end
end
