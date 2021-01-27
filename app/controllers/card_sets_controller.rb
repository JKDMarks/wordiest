class CardSetsController < ApplicationController
    def index
        @card_sets = CardSet.all
        render json: @card_sets
    end
end
