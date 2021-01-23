class CardSet < ApplicationRecord
    has_many :cards, primary_key: 'code', foreign_key: 'set'

    validates :code, uniqueness: true
end
