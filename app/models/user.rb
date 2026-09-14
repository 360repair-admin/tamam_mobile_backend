class User < ApplicationRecord
  has_many :auth_sessions, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def active?
    deleted_at.nil?
  end
end
