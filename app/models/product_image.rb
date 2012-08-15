# == Schema Information
#
# Table name: product_images
#
#  id                 :integer(4)      not null, primary key
#  product_id         :integer(4)
#  sort               :integer(4)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class ProductImage < ActiveRecord::Base
    attr_accessible  :product_id, :sort, :proved_serial,:sort_id, :color_id, :state, :rank, :price, :current_price, :introduction, :image


  belongs_to :product
  default_scope  :order => "sort"

  has_attached_file :image,
    :url => '/system/pictures/:id/:style.:extension',
    :path => ':rails_root/public/system/pictures/:id/:style.:extension',
    :styles => {
    :thumb => '64x64>' ,
    :list => '120x120',
    :w168h168 => '168x168>',
    :w140h140 => '140x140>',
    :w200h200 => '200x200>',
    :w740h740 => '740x740>',
    :original => '800x800>',
    :product => "500x500>"
  }
#  ,
#    :default_style => :product

  #  user = User.first
  #File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
  #user.save
  #  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  #  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  validates_attachment_content_type :image, :content_type => ["image/jpeg","image/x-png" ,"image/pjpeg","image/gif","image/jpg" , "image/png"  ]
#  validates_attachment_content_type :image, :content_type => ["image/jpeg","image/x-png" ,"image/pjpeg","image/gif","image/jpg" , "image/png"  ]
  def self.product_image_sort(product_image,product_id,sort)

    @product_images = ProductImage.find_all_by_product_id(product_id)
    @product_images.each_with_index {|r,index| r.sort = index + 1;r.save}
    ProductImage.transaction do
      case sort
      when "up"
        unless @product_images.first == product_image
          index  = @product_images.index(product_image)
          temp_sort = @product_images[index-1]
          temp_sort.sort = index +1
          product_image.sort = index
          temp_sort.save
          product_image.save
        end
      when "down"
        unless @product_images.last == product_image
          index  = @product_images.index(product_image)
          temp_sort = @product_images[index+1]
          temp_sort.sort = index + 1
          product_image.sort = index + 2
          temp_sort.save
          product_image.save
        end
      end
    end
    @product_images
  end
end
