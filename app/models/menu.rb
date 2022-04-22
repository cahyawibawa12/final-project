class Menu < ApplicationRecord
  belongs_to :category
  
  has_many :order_detail
  has_many :order, through: :order_details 
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :price, presence:true, numericality: { greater_than_or_equal_to: 0.01 }


  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end

  def self.by_category(category)
    left_outer_joins(:category).where(categories: {name: "#{category}"})
  end

  def set_category
    @category = Category.all.collect { |category| [ category.name, category.id ] }
  end
end