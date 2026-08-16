class CreateSmsMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :sms_messages do |t|
      t.string :phone_number, null: false
      t.text :message, null: false
      t.string :sms_provider, null: false
      t.string :sender_id, null: false

      t.datetime :sent_at
      t.datetime :failed_at
      t.integer :failed_attempts, null: false, default: 0

      t.references :sms_template, foreign_key: true

      t.timestamps null: false
    end
  end
end
