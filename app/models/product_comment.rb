# == Schema Information
#
# Table name: product_comments
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  price      :integer(4)
#  ipaddr     :string(255)
#  user_id    :integer(4)
#  product_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class ProductComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  
  validates_presence_of :user_id
end
