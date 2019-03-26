class VenueTable < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.text :name
      t.text :parking_info
      t.text :address
    end
  end
end
