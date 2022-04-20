class AddCategoryToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :category, null: false, foreign_key: true
  end
end
