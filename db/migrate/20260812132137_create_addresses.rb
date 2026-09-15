class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.boolean :is_default, default: false, null: false
      t.string :address_line
      t.string :label
      t.decimal :latitude, precision: 10, scale: 7
      t.decimal :longitude, precision: 10, scale: 7

      t.timestamps null: false
    end
  end
end
