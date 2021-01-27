class CardSetsController < ApplicationController
    def index
        @card_sets = CardSet.all
        render json: @card_sets
    end

    def show
        @card_set = CardSet.find_by_code(card_set_code)
        render json: @card_set
    end

    private

    def card_set_code
        params.require(:code)
    end
end