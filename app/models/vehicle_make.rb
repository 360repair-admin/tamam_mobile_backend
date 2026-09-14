class VehicleMake < ApplicationRecord
  # has_many :vehicle_models, dependent: :restrict_with_exception

  validates :name_en, :name_ar, presence: true
  validates :name_en, :name_ar, uniqueness: true
end
