class SubscriptionTable < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.text :name
      t.datetime :payment_process_date
      t.integer :amount
      t.string :type
      t.references :card
      t.references :company
    end
  end
end
