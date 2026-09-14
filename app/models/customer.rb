class Customer < User
  alias_attribute :full_name, :name

  validates :phone_number, presence: true, uniqueness: true
end
