class Notification < ApplicationRecord
  belongs_to :user, optional: true

  scope :public_notifications, -> { where(customer_id: nil) }
  scope :unread, -> { where(read_at: nil) }
end
