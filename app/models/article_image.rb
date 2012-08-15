# == Schema Information
#
# Table name: article_images
#
#  id                 :integer(4)      not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  article_id         :integer(4)
#  sort               :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

class ArticleImage < ActiveRecord::Base
  belongs_to :article
    default_scope  :order => "sort"
    has_attached_file :image,
    :url => '/system/article/:id/:style.:extension',
    :path => ':rails_root/public/system/article/:id/:style.:extension',
    :styles => {
    :thumb => '64x64>' ,
    :list => '120x120',
    #    :category => "220x164",
    :article => "500x500>"
  } ,
    :default_style => :article

#  user = User.first
#File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
#user.save
  validates_attachment_presence :image
#  validates_attachment_size :image, :less_than => 3.megabytes
#  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']


    def self.article_image_sort(article_image,article_id,sort)

    @article_images = ArticleImage.find_all_by_article_id(article_id)
    @article_images.each_with_index {|r,index| r.sort = index + 1;r.save}
      case sort
      when "up"
        unless @article_images.first == article_image
          index  = @article_images.index(article_image)
          temp_sort = @article_images[index-1]
          temp_sort.sort = index +1
          article_image.sort = index
          temp_sort.save
          article_image.save
        end
      when "down"
        unless @article_images.last == article_image
          index  = @article_images.index(article_image)
          temp_sort = @article_images[index+1]
          temp_sort.sort = index + 1
          article_image.sort = index + 2
          temp_sort.save
          article_image.save
        end
      end
    @article_images
  end
end
