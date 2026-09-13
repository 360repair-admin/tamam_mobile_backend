class CreateAuthSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :auth_sessions do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :jti, null: false
      t.datetime :expires_at, null: false
      t.datetime :revoked_at

      t.timestamps null: false
    end
  end
end
