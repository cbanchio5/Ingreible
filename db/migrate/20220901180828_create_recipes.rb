class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :ingredients
      t.string :difficulty
      t.integer :time

      t.timestamps
    end
  end
end
