class CardSet < ApplicationRecord
    has_many :cards, primary_key: 'code', foreign_key: 'set'
    has_many :stats, foreign_key: :card_set_id, class_name: 'CardSetStat'

    validates :code, uniqueness: true
end
