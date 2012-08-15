# == Schema Information
#
# Table name: colors
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  sort        :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Color < ActiveRecord::Base
  default_scope  :order => "sort"


  validates_presence_of :name
  validates_length_of :name, :within => 1..60 , :allow_blank=> true
  validates_uniqueness_of :name
  
  before_create :set_sort
  
  def set_sort
    self.sort = Color.all.size + 1
  end
  
  has_many :products
  
  
  
  
  

  def self.color_sort(color,sort)

    @colors = Color.all
    @colors.each_with_index {|r,index| r.sort = index + 1;r.save}
    Color.transaction do
      case sort
      when "up"
        unless @colors.first == color
          index  = @colors.index(color)
          temp_color = @colors[index-1]
          temp_color.sort = index +1 
          color.sort = index
          temp_color.save
          color.save
        end
      when "down"
        unless @colors.last == color
          index  = @colors.index(color)
          temp_color = @colors[index+1]
          temp_color.sort = index + 1
          color.sort = index + 2
          temp_color.save
          color.save
        end
      end
    end
    @colors
  end
 
end
