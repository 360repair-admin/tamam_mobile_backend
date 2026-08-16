class CreateSmsTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :sms_templates do |t|
      t.string :name_en, null: false
      t.string :name_ar, null: false
      t.string :unique_name, null: false, index: { unique: true }
      t.text :message_body_en, null: false
      t.text :message_body_ar, null: false
      t.boolean :system, default: false, null: false
      t.timestamps null: false
    end
  end
end
