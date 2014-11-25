class CreateItemsUsers < ActiveRecord::Migration
  def change
    create_table :items_users do |t|
      t.references :item, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
