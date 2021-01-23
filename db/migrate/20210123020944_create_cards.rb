class CreateCards < ActiveRecord::Migration[6.1]
    def change
        create_table :cards do |t|
            t.string :name
            t.string :set
            t.string :type_line
            t.string :oracle_text
            t.integer :pow
            t.integer :tou
            t.integer :cmc
        end
    end
end
