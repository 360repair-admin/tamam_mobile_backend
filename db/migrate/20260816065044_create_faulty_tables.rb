class CreateFaultyTables < ActiveRecord::Migration[6.0]
  def change
    create_table :faulty_errors do |t|
      t.string   :error_class, null: false
      t.string   :message, null: false, default: "No message provided"
      t.string   :fingerprint, null: false, index: { unique: true }
      t.datetime :last_event_at, null: false
      t.string :status, null: false, default: "unresolved"

      t.references :resolved_by, polymorphic: true
      t.datetime :resolved_at

      t.references :assigned_to, polymorphic: true
      t.references :assigned_by, polymorphic: true
      t.datetime :assigned_at

      t.timestamps null: false
    end

    create_table :faulty_events do |t|
      t.references :faulty_error, null: false, foreign_key: true

      t.text    :backtrace, null: false
      t.jsonb   :context, default: {}
      t.jsonb   :code_snippet, default: {}
      t.string  :request_id
      t.string  :status, null: false, default: "unresolved"

      t.timestamps null: false
    end
  end
end
