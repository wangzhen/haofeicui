class CreateProductComments < ActiveRecord::Migration
  def self.up
    create_table :product_comments do |t|
      t.string :content
      t.integer :price
      t.string :ipaddr
      t.references :user
      t.references :product

      t.timestamps
    end
  end

  def self.down
    drop_table :product_comments
  end
end
