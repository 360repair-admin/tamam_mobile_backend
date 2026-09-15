class VehicleModel < ApplicationRecord
  belongs_to :vehicle_make

  validates :name_en, :name_ar, presence: true

  validates :name_en, uniqueness: { scope: :vehicle_make_id }
  validates :name_ar, uniqueness: { scope: :vehicle_make_id }
end
