class Region < ApplicationRecord
  has_many :cities, dependent: :restrict_with_exception

  belongs_to :country

  validates :name_en, presence: true
  validates :name_ar, presence: true
end
