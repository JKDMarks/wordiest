class CreateCardSetStats < ActiveRecord::Migration[6.1]
    def change
        create_table :card_set_stats do |t|
            t.integer :card_set_id
            t.string :name
            t.float :value
        end
    end
end
