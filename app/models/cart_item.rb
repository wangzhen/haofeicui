require "uuidtools"
class CartItem
  attr_accessor :id # can not change id after assigned  # 产品ID
  attr_accessor :quantity
  attr_accessor :item_id
  
  def initialize(id, quantity)
    @id, @quantity = id.to_s, quantity.to_i
    @item_id = UUID.random_create
  end
  
  def product
     Product.find_by_id(self.id)
  end
  def subtotal
    product.price*quantity
  end
  
  def to_param
    return @id
  end
end
