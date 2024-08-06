class Perfume < ApplicationRecord
  has_many :perfume_results, dependent: :destroy
  has_many :results, through: :perfume_results
  has_many :notes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :illustration

  validates :name, presence: true
  validates :description, presence: true
  validates :brand, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :photo, presence: true
  validates :intensity, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :genre, inclusion: { in: ["Pour femme", "Pour homme", "Mixte"] }
  validates :period, inclusion: { in: ["Journée", "Soirée", "Tout le temps"] }
  validates :season, inclusion: { in: ["Plutôt l’été", "Plutôt l’hiver", "Toute l'année"] }
  validates :situations, inclusion: { in: ["Un week-end intense", "Un déjeuner entre amis", "Un moment cocooning", "Toute occasion"] }
  validates :smell, inclusion: { in: ["Un jus d’agrumes vitaminé", "Un bouquet de fleurs", "Un fruit frais ou sucré", "Un dessert très gourmand", "Une balade en forêt", "Un bouquet d’herbes et aromates", "Des embruns rafraichissants", "Un souvenir de vacances épicé", "Un cocktail intense et puissant"] }
end
