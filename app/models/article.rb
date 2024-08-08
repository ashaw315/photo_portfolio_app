class Article < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio

  validates :title, presence: true, length: { minimum: 3 }
  validates :content, presence: true
end
