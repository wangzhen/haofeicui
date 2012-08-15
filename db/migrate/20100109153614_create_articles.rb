class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :subhead
      t.string :from
      t.string :author
      t.string :summary
      t.text :body
      t.string :status
      t.references :category
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
