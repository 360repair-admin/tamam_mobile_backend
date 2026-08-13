class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.boolean :is_default, default: false, null: false
      t.string :address_line

      t.timestamps null: false
    end
  end
end
