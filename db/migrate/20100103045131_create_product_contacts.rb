class CreateProductContacts < ActiveRecord::Migration
  def self.up
    create_table :product_contacts do |t|
      t.string :name
      t.string :reply
      t.string :ipaddr
      t.references :user
      t.references :product
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :product_contacts
  end
end
