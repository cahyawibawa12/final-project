class Menu < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :price, presence:true, numericality: { greater_than_or_equal_to: 0.01 }


  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end

  def self.by_category(category)
    left_outer_joins(:category).where(categories: {name: "#{category}"})
  end
end

