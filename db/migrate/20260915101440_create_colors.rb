class CreateColors < ActiveRecord::Migration[8.1]
  def change
    create_table :colors do |t|
      t.string :name_ar, null: false
      t.string :name_en, null: false

      t.timestamps null: false
    end
  end
end
