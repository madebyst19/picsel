class CartItem < ApplicationRecord
    belongs_to :user
    belongs_to :photo
    validates :amount, presence: true
end
