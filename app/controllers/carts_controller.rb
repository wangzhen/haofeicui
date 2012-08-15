# coding: utf-8
class CartsController < ApplicationController
#  include AuthenticatedSystem
  before_filter :init_cart
  def index
    @html_title = "购物车首页"
    unless params[:product].blank?
      @cart.add_item( params[:product] , 1)
    end
    #    @products = Product.find(@cart)
  end

  def show
    store_location
  end

  def update
    @cart.update(params[:items])
    redirect_to :action => :index
  end

  def alipay
    @name = params[:name]
    @zip = params[:zip]
    @phone = params[:phone]
    @adress = params[:adress]
    @mobile = params[:mobile]
    @order = Order.new
    @order.address =@adress
    @order.user_name = @name
    @order.phone = @phone
    @order.mobile = @mobile
    @order.postal_code = @zip
    @order.user_remark = "#{@product.try(:id)}#{@products.try(:name)}"
    if @cart.items.blank?
      redirect_to root_path
    else
      @first_id = @cart.items.first.id
      @body = @cart.items.collect {|item| "product_id:#{item.product.id}--price:#{item.product.price}||"}
      @order.user_remark = @body

    end
    @order.save
  end
 
  protected

  def init_cart
    @cart = (session[:cart] ||= Cart.new)
  end

end
