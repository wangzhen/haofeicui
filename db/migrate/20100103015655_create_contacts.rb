class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :serial
      t.string :phone
      t.string :name
      t.string :email
      t.string :qq
      t.string :content
      t.string :reply
      t.string :ipaddr
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
