class VenueEventTable < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_event do |t|
      t.datetime :event_date
      t.references :venue
      t.references :event
    end
  end
end
