class Color < ApplicationRecord
  has_many :vehicles, dependent: :restrict_with_exception

  validates :name_ar, presence: true, uniqueness: true
  validates :name_en, presence: true, uniqueness: true
end
