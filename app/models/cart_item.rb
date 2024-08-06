class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :perfume

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
