class Card < ApplicationRecord
    belongs_to :card_set, primary_key: 'code', foreign_key: 'set'

    validates :name, uniqueness: { scope: :set }
end
