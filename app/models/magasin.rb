class Magasin < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :brand, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
