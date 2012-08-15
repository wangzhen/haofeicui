class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :serial
      t.string :proved_serial
      t.references :sort
      t.references :color
      t.references :user
      t.integer :price
      t.integer :current_price
      t.text :introduction
      t.integer :rank
      t.integer :hits
      t.integer :state

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
