class Customer < ApplicationRecord
  has_many :addresses, dependent: :destroy
end
