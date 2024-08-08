class Photo < ApplicationRecord
  has_one_attached :image
  belongs_to :portfolio
  belongs_to :article
  belongs_to :user
end
