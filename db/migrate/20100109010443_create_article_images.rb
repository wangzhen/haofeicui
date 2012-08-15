class CreateArticleImages < ActiveRecord::Migration
  def self.up
    create_table :article_images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.integer :article_id
      t.integer :sort , :defalut => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :article_images
  end
end
