class CreateCardSets < ActiveRecord::Migration[6.1]
  def change
    create_table :card_sets do |t|
      t.string :code
      t.string :name
      t.date :released_at
    end
  end
end
