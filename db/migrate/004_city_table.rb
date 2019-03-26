class CityTable < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
    end
  end
end
