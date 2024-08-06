class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :results, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_perfumes, through: :favorites, source: :perfume
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true
  validates :surname, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
