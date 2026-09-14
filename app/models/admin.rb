class Admin < User
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
end
