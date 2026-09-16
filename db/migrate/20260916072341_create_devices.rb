class CreateDevices < ActiveRecord::Migration[8.1]
  def change
    create_table :devices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.string :platform, null: false
      t.string :app_version
      t.datetime :last_seen_at

      t.timestamps null: false
    end
  end
end
