class Cart
  attr_accessor :items
  attr_accessor :loggin
  
  def initialize
    @items = []
  end
  
  # Append an item into shopping, by increasing it's quantity if it is already
  # exists.
  def add_item(product_id, quantity)
    product = Product.find(product_id) # product is exists?

      quantity = quantity.blank? ? 1 : (quantity.to_i > 99? 99 : quantity.to_i)

      return if quantity < 1 # return if invalid quantity is provided
    
      if cart_item = @items.find { |item| item.id.to_i == product_id.to_i }
        cart_item.quantity += quantity
        cart_item.quantity < 99 ?   cart_item.quantity  : cart_item.quantity =99
      else
        @items << CartItem.new(product.id, quantity)
      end

  end
  
  # Remove an item from shpping. The <code>product_id</code> passed in should
  # be a <tt>string</tt> or <tt>integer</tt>.
  def remove_item(item_id)
    @items.delete_if { |item| item.id.to_i == item_id.to_i}
  end
  
  # Update quantites of all items in cart. However this is a reset operation
  # with removing and rebuilding.
  # <code>items</code> passed in is a <tt>Hash</tt>, product id as key and
  # quantity as value. 
  def update(items)
    #    clear!
    self.items.each do |i|
      number = items[i.id].blank? ? 1 : items[i.id].to_i <= 0 ? 1 : items[i.id]
      number.to_i < 99 ?  i.quantity = number.to_i : i.quantity=99
    end
    #    items.each { |id, quantity| add_items(id, quantity)  }
  end
  
  # Empty shopping cart by removing all items from it.
  def clear!
    @items.clear
  end
  
  # Return the subtotal of items' price stored in shopping cart.
    def subtotal
    @items.sum { |item| item.subtotal }
  end
  
  # Calculate the delivering charge of these items.
  def shipping_charge
    if empty? || subtotal >= 100
      return 0
    else
      return 10
    end
  end
  
  def total
    subtotal + shipping_charge
  end
  
  def empty?
    @items.empty?
  end
end
