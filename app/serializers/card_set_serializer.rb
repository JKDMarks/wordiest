class CardSetSerializer < ActiveModel::Serializer
    attributes :code, :name, :released_at, :stats
    has_many :stats#, serializer: CardSetStatSerializer
end
