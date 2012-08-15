class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :status , :default => 1
      t.string :serial
      t.integer :subtotal 
      t.integer :total 
      t.integer :adjustment
      t.integer :mailing_commition 
      t.integer :payment
      t.string :user_name
      t.integer :mailing_id
      t.date :delivery_schedule_date
      t.string :delivery_serial
      t.date :completed_on
      t.integer :province_id
      t.integer :city_id
      t.integer :district_id
      t.string :address
      t.string :postal_code
      t.string :phone
      t.string :mobile
      t.string :email
      t.string :user_remark
      t.string :admin_remark
      t.datetime :deleted_at
      t.string :fax
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
