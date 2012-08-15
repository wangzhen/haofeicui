# == Schema Information
#
# Table name: product_contacts
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  reply      :string(255)
#  ipaddr     :string(255)
#  user_id    :integer(4)
#  product_id :integer(4)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ProductContact < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
end
