# == Schema Information
#
# Table name: sorts
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  sort        :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Sort < ActiveRecord::Base

  default_scope  :order => "sort"
  
  validates_presence_of :name
  validates_length_of :name, :within => 1..60 , :allow_blank=> true
  validates_uniqueness_of :name
  
  has_many :products
  
  before_create :set_sort
  
  def set_sort
    self.sort = Color.all.size + 1
  end
  
  
  
  

  def self.sort_sort(sort_obj,sort)

    @sorts = Sort.all
    @sorts.each_with_index {|r,index| r.sort = index + 1;r.save}
    Sort.transaction do
      case sort
      when "up"
        unless @sorts.first == sort_obj
          index  = @sorts.index(sort_obj)
          temp_sort = @sorts[index-1]
          temp_sort.sort = index +1
          sort_obj.sort = index
          temp_sort.save
          sort_obj.save
        end
      when "down"
        unless @sorts.last == sort_obj
          index  = @sorts.index(sort_obj)
          temp_sort = @sorts[index+1]
          temp_sort.sort = index + 1
          sort_obj.sort = index + 2
          temp_sort.save
          sort_obj.save
        end
      end
    end
    @sorts
  end
 
end
