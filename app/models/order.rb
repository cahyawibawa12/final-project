class Order < ApplicationRecord
  has_many :order_details
  has_many :menus, through: :order_details
  
  validates :customer_email, presence: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "not valid" }

  validates :total, presence: true
  validates :order_date, presence: true
  validates :status, presence: true

  def create_menu(menus)
    if menus.nil?
      self.errors.add(:order, "at least have 1 menu")
      return
    end
    menus.each do |menu|
      if Menu.find_by_id(menu[:id]).present?
        self.order_details << OrderDetail.new(menu_id: menu[:id], qty: menu[:qty], price: Menu.where(id: menu[:id])[0].price)
      else
        self.errors.add(:menu, "with id: #{menu[:id]} is not exits")
      end
      self.errors.add(:menu, "quantity must more than 0") if menu[:qty].to_i < 1
    end
  end

  def sum_subtotal
    self.order_details.each do |order_detail|
      order_detail.sum_subtotal
    end
  end

    def sum_total
      self.order_details.each do |order_detail|
        self.total = self.total + order_detail.sub_total
      end
    end
end
