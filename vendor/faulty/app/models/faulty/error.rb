module Faulty
  class Error < ApplicationRecord
    has_many :events, class_name: "Faulty::Event", foreign_key: "faulty_error_id", dependent: :destroy
    has_many :comments, class_name: "Faulty::Comment", foreign_key: "faulty_error_id", dependent: :destroy

    belongs_to :resolved_by, polymorphic: true, optional: true
    belongs_to :assigned_by, polymorphic: true, optional: true
    belongs_to :assigned_to, polymorphic: true, optional: true

    def unique_users_count
      user_ids = events.map { |e| e.context&.dig("current_user", "id") }.compact.uniq
      user_ids.count
    end
  end
end
