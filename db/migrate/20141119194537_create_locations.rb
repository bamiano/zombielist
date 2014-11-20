class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_type
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
