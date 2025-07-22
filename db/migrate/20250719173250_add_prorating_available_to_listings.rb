class AddProratingAvailableToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :prorating_available, :boolean
  end
end
