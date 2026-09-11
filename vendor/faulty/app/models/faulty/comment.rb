module Faulty
  class Comment < ApplicationRecord
    belongs_to :faulty_error, class_name: "Faulty::Error"
    belongs_to :author, polymorphic: true

    validates :content, presence: true
  end
end
