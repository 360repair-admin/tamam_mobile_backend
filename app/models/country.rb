class Country < ApplicationRecord
  has_many :regions, dependent: :restrict_with_exception

  validates :name_en, presence: true
  validates :name_ar, presence: true
end
