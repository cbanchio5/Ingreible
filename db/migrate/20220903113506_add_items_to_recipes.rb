class AddItemsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :steps, :text
    add_column :recipes, :serves, :integer
    add_column :recipes, :category, :string
  end
end
