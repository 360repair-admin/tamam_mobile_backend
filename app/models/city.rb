class City < ApplicationRecord
  belongs_to :region

  validates :name_en, presence: true
  validates :name_ar, presence: true
end
