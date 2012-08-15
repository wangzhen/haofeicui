class CreateProdcutQuestions < ActiveRecord::Migration
  def self.up
    create_table :prodcut_questions do |t|
      t.string :comment
      t.integer :meddle
      t.string :ipaddr
      t.references :user
      t.references :product

      t.timestamps
    end
  end

  def self.down
    drop_table :prodcut_questions
  end
end
