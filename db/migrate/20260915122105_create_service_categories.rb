class CreateServiceCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :service_categories do |t|
      t.string :name_en, null: false
      t.string :name_ar, null: false
      t.text :description_en
      t.text :description_ar
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :service_categories, :name_en, unique: true
  end
end
