# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# API_URL = 'https://api.scryfall.com/'

# resp = JSON.parse(HTTParty.get(API_URL + 'sets').body)

# sets = resp['data'].filter do |set|
#     set['set_type'] == 'core' || set['set_type'] == 'expansion'
# end

# sets.each do |set|
#     CardSet.create(set.slice('code', 'name', 'released_at'))
# end

# resp = JSON.parse(HTTParty.get(API_URL + "cards/search?q=e:#{cs.code} unique:cards").body)

def create_cards(cs)
    url = API_URL + "cards/search?q=e:#{cs.code} unique:cards"

    def create_from_url(url)
        resp = JSON.parse(HTTParty.get(url).body)

        resp['data'].each do |cd|
            card = Card.new(name: cd['name'], pow: cd['power'], tou: cd['toughness'], cmc: cd['cmc'],
                            set: cd['set'], oracle_text: cd['oracle_text'], type_line: cd['type_line'])

            if cd['card_faces']
                card[:oracle_text] = cd['card_faces'].reduce('') do |str, face|
                    "#{str} #{face['oracle_text']}"
                end[1..]
            end

            card.save
        end

        create_from_url(resp['next_page']) if resp['has_more']
    end

    create_from_url(url)
end

# CardSet.all.each { |cs| create_cards(cs) }

CardSet.all.each do |cs|
    # with = 0
    # without = 0
    
    # cs.cards.each do |cd|
    #     w_arr = cd.oracle_text.split(/[\n ]/)
    #     with += w_arr.length

    #     wo_arr = cd.oracle_text.gsub(/ ?\(.+\)/, '').split(/[ \n]/)
    #     without += wo_arr.length
    # end

    # CardSetStat.create(name: 'With Oracle', value: with, card_set: cs)
    # CardSetStat.create(name: 'Without Oracle', value: without, card_set: cs)
    ct = cs.stats.find_by_name('Count').value
    with = cs.stats.find_by_name('With Oracle').value
    without = cs.stats.find_by_name('Without Oracle').value
    
    CardSetStat.create(name: 'With Oracle Avg', value: with / (1.0 * ct), card_set: cs)
    CardSetStat.create(name: 'Without Oracle Avg', value: without / (1.0 * ct), card_set: cs)
end