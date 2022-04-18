class Menu < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence:true, numericality: { greater_than_or_equal_to: 0.01 }


  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
