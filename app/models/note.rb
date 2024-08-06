class Note < ApplicationRecord
  belongs_to :perfume

  validates :tete, presence: true
  validates :coeur, presence: true
  validates :fond, presence: true
end
