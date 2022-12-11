class Comment < ApplicationRecord
  validates :content, presence: true, length: {minimum: 10}

  belongs_to :prototype
  belongs_to :user
end
