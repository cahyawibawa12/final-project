class Category < ApplicationRecord
  has_many :menu

  validates :name, presence: true, uniqueness: true

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
