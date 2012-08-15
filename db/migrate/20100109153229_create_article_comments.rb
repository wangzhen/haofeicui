class CreateArticleComments < ActiveRecord::Migration
  def self.up
    create_table :article_comments do |t|
      t.text :content
      t.string :ipaddr
      t.references :user
      t.references :article

      t.timestamps
    end
  end

  def self.down
    drop_table :article_comments
  end
end
