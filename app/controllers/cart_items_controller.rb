# coding: utf-8
class CartItemsController < ApplicationController
  before_filter :init_cart

  def create
    @amount = @cart.items.size
    @cart.add_item(params[:cart_item][:id],params[:cart_item][:quantity])
    if @cart.items.size < @amount
      flash[:notice] = "the product has been added into your cart"
    end
    redirect_to cart_path
  end

  def show
    if @cart.items.size == 0
      redirect_to root_url
      flash[:notice] = "your cart is empty"
    end
  end

  def destroy
    if @cart.remove_item(params[:id])
      flash[:notice] = t("flash.destroy_success")
    end
    redirect_to '/carts'
  end

  protected
  
  def init_cart
    @cart = (session[:cart] ||= Cart.new)
  end
end