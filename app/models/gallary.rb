class Gallary < ApplicationRecord
    has_many :photos, dependent: :destroy
end
