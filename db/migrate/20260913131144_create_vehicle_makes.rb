class CreateVehicleMakes < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicle_makes do |t|
      t.string :name_en, null: false
      t.string :name_ar, null: false

      t.timestamps null: false
    end
  end
end
