class VehicleMake < ApplicationRecord
  validates :name_en, :name_ar, presence: true
  validates :name_en, :name_ar, uniqueness: true
end
