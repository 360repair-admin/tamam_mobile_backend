class Vehicle < ApplicationRecord
  belongs_to :customer, foreign_key: :user_id
  belongs_to :vehicle_model
  belongs_to :color

  validates :plate_number, presence: true
  validates :plate_left_letter, presence: true
  validates :plate_middle_letter, presence: true
  validates :plate_right_letter, presence: true
  validates :manufacturing_year, presence: true
end
