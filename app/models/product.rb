# coding: utf-8
# == Schema Information
#
# Table name: products
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  serial        :string(255)
#  proved_serial :string(255)
#  sort_id       :integer(4)
#  color_id      :integer(4)
#  user_id       :integer(4)
#  price         :integer(4)
#  current_price :integer(4)
#  introduction  :text
#  rank          :integer(4)
#  hits          :integer(4)
#  state         :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#


# rank   0已审核 1未审核  2促销 3推荐 4精品
#state -1下架 0锁定  1未售  2已出售
class Product < ActiveRecord::Base
  attr_accessible  :name, :serial, :proved_serial,:sort_id, :color_id, :state, :rank, :price, :current_price, :introduction, :image

  RANK = {   2=>"促销",    3=>"推荐",    3=>'精品'  }
  STATE = {    -1=> "下架",    0=>"锁定",    1=>"未售",    2=>"已出售"  }

#  default_scope  :order => "sort"
  has_many :product_images
  accepts_nested_attributes_for :product_images
  belongs_to :sort
  belongs_to :color
  belongs_to :user
  has_many :order_lines
  has_many :product_contacts
  has_many :product_comments

  validates_presence_of :name
  validates_presence_of :sort_id
  validates_presence_of :color_id
#  validates_presence_of :user_id
  validates_presence_of :serial
  validates_presence_of :proved_serial
  validates_presence_of :state
  validates_presence_of :introduction
  validates_presence_of :price

  validates_length_of :introduction, :within => 1..80000 , :allow_blank=> true
  validates_length_of :name, :within => 1..60 , :allow_blank=> true
  validates_length_of :serial, :within => 1..60 , :allow_blank=> true
  validates_length_of :proved_serial, :within => 1..60 , :allow_blank=> true
  validates_numericality_of :price , :less_than=>5000000.00
  
  validates_uniqueness_of :serial
  validates_uniqueness_of :proved_serial

  def first_list_image(style= :w168h168 )
   if  self.try(:product_images).try(:first).try(:image)
     self.try(:product_images).try(:first).try(:image).url(style)
   else
     '/images/36.jpg'
   end
  end

  def get_rank
      RANK[self.rank]
  end
    
  def get_state
      STATE[self.state]
  end

end
