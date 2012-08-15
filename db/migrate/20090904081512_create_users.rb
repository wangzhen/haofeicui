class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :name,                      :string, :limit => 50
      t.column :email,                     :string, :limit => 50 ,:null => false
      t.column :crypted_password,          :string
      t.column :salt,                      :string
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string
      t.column :activated_at,              :datetime
      t.column :nickname,                  :string, :limit => 50
      t.column :rank,                      :integer ,:default => 0
      t.column :introduction ,             :string  ,:limint=> 255
      t.column :point,                     :integer , :default=>0
      t.column :coin,                      :integer  ,:defalult=>0
      t.column :phone,                     :string , :limit=> 20 
      t.column :mobile,                    :string , :limit=> 20
      t.column :address,                   :string , :limit=> 100
      t.column :province_id,               :integer
      t.column :city_id,                   :integer
      t.column :district_id,               :integer
      t.column :state,                     :integer  ,:default => 0
      
      t.string :image_file_name , :limit=>50
      t.string :image_content_type 
      t.integer :image_file_size
      t.datetime :image_updated_at


    end
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
