class CardTable < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :card_number
      t.references :customer
    end
  end
end
