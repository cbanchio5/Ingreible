class ChangeFieldTypeRecipes < ActiveRecord::Migration[6.1]
  change_column(:recipes, :time, :string)
end
