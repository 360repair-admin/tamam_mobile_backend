class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.references :customer, null: true, foreign_key: true

      t.string :title_en, null: false
      t.string :title_ar, null: false

      t.text :body_en, null: false
      t.text :body_ar, null: false

      t.datetime :read_at

      t.timestamps null: false
    end
  end
end
