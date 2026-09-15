class CreateVehicleModels < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicle_models do |t|
      t.references :vehicle_make, null: false, foreign_key: true

      t.string :name_en, null: false
      t.string :name_ar, null: false

      t.timestamps null: false
    end

    add_index :vehicle_models, [ :vehicle_make_id, :name_en ], unique: true
    add_index :vehicle_models, [ :vehicle_make_id, :name_ar ], unique: true
  end
end
