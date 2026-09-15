class Customer < User
  has_many :vehicles, foreign_key: :user_id, dependent: :destroy
  has_many :addresses, foreign_key: :user_id, dependent: :destroy

  alias_attribute :full_name, :name

  validates :phone_number, presence: true, uniqueness: true
end
