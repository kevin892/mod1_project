class EventTable < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.text :name
      t.text :url
      t.datetime :sale_start_date
      t.string :genre
      t.integer :min_price
    end
  end
end
