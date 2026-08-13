class CreateRegions < ActiveRecord::Migration[8.1]
  def change
    create_table :regions do |t|
      t.references :country, null: false, foreign_key: true

      t.string :name_en, null: false
      t.string :name_ar, null: false
      t.string :code

      t.timestamps null: false
    end
  end
end
