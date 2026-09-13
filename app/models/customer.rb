class Customer < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :auth_sessions, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :locale, inclusion: { in: %w[ar en] }
end
