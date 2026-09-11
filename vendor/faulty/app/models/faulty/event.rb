module Faulty
  class Event < ApplicationRecord
    belongs_to :error, class_name: "Faulty::Error", foreign_key: "faulty_error_id"

    after_create :update_error_status, if: -> { error.status == "resolved" }

    private

    def update_error_status
      error.update(status: "unresolved", resolved_at: nil, resolved_by: nil)
    end
  end
end
