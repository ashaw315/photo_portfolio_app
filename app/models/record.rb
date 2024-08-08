class Record < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  belongs_to :video
end
