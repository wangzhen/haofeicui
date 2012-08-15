# == Schema Information
#
# Table name: prodcut_questions
#
#  id         :integer(4)      not null, primary key
#  comment    :string(255)
#  meddle     :integer(4)
#  ipaddr     :string(255)
#  user_id    :integer(4)
#  product_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class ProdcutQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
end
