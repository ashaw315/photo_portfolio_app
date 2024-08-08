class User < ApplicationRecord
    has_secure_password
    has_many :portfolios
    has_many :photos
    has_many :articles
    has_many :videos
    has_many :records
    has_many :comments
    has_many :likes
  
    validates :name, presence: true
  
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
    validates :password_confirmation, presence: true, if: -> { password.present? }
  
    private
  
    # Check if password is required based on whether it is being updated
    def password_required?
      new_record? || password.present?
    end
  end
  