class CreateCities < ActiveRecord::Migration[8.1]
  def change
    create_table :cities do |t|
      t.references :region, null: false, foreign_key: true

      t.string :name_en, null: false
      t.string :name_ar, null: false

      t.timestamps null: false
    end
  end
end
