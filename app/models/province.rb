# == Schema Information
#
# Table name: provinces
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Province < ActiveRecord::Base
  has_many :cities


    validates_presence_of :name
  validates_length_of       :name,        :maximum => 50  , :allow_nil => true
end
