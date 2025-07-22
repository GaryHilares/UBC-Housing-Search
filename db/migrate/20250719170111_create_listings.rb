class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.belongs_to :residence
      t.belongs_to :room_type
      t.integer :monthly_rate
      t.integer :security_deposit
      t.boolean :open_to_negotiation
      t.string :gender
      t.string :other_details
      t.string :start_date
      t.string :end_date
      t.timestamps
    end
  end
end
