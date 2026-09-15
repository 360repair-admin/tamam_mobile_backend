class Address < ApplicationRecord
  belongs_to :customer, foreign_key: :user_id
  belongs_to :city

  validates :address_line, presence: true

  before_save :make_default, if: :is_default?

  private

  def make_default
    customer.addresses
            .where.not(id: id)
            .update_all(is_default: false)
  end
end
