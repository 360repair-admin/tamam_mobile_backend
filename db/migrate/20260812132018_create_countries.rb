class CreateCountries < ActiveRecord::Migration[8.1]
  def change
    create_table :countries do |t|
      t.string :name_en, null: false
      t.string :name_ar, null: false
      t.string :code

      t.timestamps null: false
    end
  end
end
