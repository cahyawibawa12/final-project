class Category < ApplicationRecord
  has_many :menu

  validates :name, presence: true, uniqueness: true
end
