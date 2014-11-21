class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item
      t.text :url
      t.text :image
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
