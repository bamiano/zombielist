class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :password_digest
      t.integer :location

      t.timestamps
    end
  end
end
