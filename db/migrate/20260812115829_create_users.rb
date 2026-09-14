class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :type, null: false

      t.string :phone_number, index: { unique: true }
      t.datetime :phone_number_verified_at

      t.string :name
      t.string :email, index: { unique: true }
      t.string :locale, default: :ar, null: false

      t.string :password_digest

      t.datetime :terms_accepted_at
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
