class CreateOtpRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :otp_requests do |t|
      t.string :phone_number
      t.string :purpose
      t.string :code_digest
      t.string :request_id
      t.datetime :expires_at
      t.datetime :consumed_at
      t.integer :attempts

      t.timestamps null: false
    end
  end
end
