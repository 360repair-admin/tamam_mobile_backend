class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :phone_number, null: false, index: { unique: true }
      t.datetime :phone_number_verified_at, null: false
      t.string :full_name
      t.string :email
      t.string :locale, default: :ar, null: false

      t.timestamps null: false
    end
  end
end
