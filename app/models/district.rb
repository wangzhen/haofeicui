# == Schema Information
#
# Table name: districts
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  city_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class District < ActiveRecord::Base
  belongs_to :city

  validates_presence_of :name
  validates_length_of       :name,        :maximum => 50  , :allow_nil => true
end
