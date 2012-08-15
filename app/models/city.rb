# == Schema Information
#
# Table name: cities
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  province_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class City < ActiveRecord::Base
  belongs_to :province
  has_many :districts

  validates_presence_of :name
  validates_length_of       :name,        :maximum => 50  , :allow_nil => true
end
