class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :plate_number, null: false
      t.string :plate_left_letter, null: false
      t.string :plate_middle_letter, null: false
      t.string :plate_right_letter, null: false
      t.references :vehicle_model, null: false, foreign_key: true
      t.integer :manufacturing_year, null: false
      t.references :color, null: false, foreign_key: true
      t.string :chassis_number

      t.timestamps null: false
    end
  end
end
