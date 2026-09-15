class ServiceCategory < ApplicationRecord
  validates :name_en, presence: true, uniqueness: true
  validates :name_ar, presence: true
end
