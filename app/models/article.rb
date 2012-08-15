# == Schema Information
#
# Table name: articles
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  subhead     :string(255)
#  from        :string(255)
#  author      :string(255)
#  summary     :string(255)
#  body        :text
#  status      :string(255)
#  category_id :integer(4)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Article < ActiveRecord::Base

  validates_presence_of :category_id
  validates_presence_of :title

  validates_presence_of :summary
  validates_presence_of :body
  validates_uniqueness_of :title
  belongs_to :category
  has_many :article_comments
  has_many :article_images
  
  
  def first_list_image
   if  self.try(:article_images).try(:first).try(:image)
     self.try(:article_images).try(:first).try(:image).url(:list).to_s
   else
     ''
   end
  end
end
