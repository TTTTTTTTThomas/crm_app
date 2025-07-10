class Customer < ApplicationRecord
  has_one_attached :image
  
  validates :full_name, presence: true
  validates :phone_number, presence: true
end
