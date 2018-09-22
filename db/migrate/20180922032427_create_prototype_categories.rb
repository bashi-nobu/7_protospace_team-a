class CreatePrototypeCategories < ActiveRecord::Migration
  def change
    create_table :prototype_categories do |t|
      t.integer :prototype_id
      t.integer :category_id
      t.timestamps
    end
    add_index :prototype_categories, :prototype_id
    add_index :prototype_categories, :category_id
    add_index :prototype_categories, [:prototype_id,:category_id],unique: true
  end
end
