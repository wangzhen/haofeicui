class CreateSorts < ActiveRecord::Migration
  def self.up
    create_table :sorts do |t|
      t.string :name
      t.string :description
      t.integer :sort

      t.timestamps
    end
  end

  def self.down
    drop_table :sorts
  end
end
