class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.integer :order_id
      t.integer :product_id
      t.string :name
      t.string :sort
      t.string :color
      t.integer :quantity
      t.integer :price
      t.text :remark
      t.timestamps
    end
  end

  def self.down
    drop_table :order_lines
  end
end
