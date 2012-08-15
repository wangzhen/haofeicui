# coding: utf-8
class OrdersController < ApplicationController
#  ssl_required :new,:create if SSL_ENABLE
#  ssl_allowed :payment , :create_payment ,:show if SSL_ENABLE

  before_filter :auth_order,:only => [:show,:result,:payment]
  def index
    if current_user.blank? && session[:order].blank?
      redirect_to cart_path
    elsif current_user.blank?
      p session[:order_ids]
        @orders = Order.find(session[:order_ids])
    else
      @orders = Order.find_all_by_user_id(current_user.id)
    end
    
  end
  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find_by_serial(params[:id])
    @html_title = @order.serial

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @html_tite = "新建订单页"
    if session[:order].blank?
      @order = Order.new
    else
      @order = session[:order]
      @province = @order.try(:province)
      @cities = @province.try(:cities)
      @city = @order.try(:city)
      @districts = @city.try(:districts)
    end
    #    if session[:cart].blank? or session[:cart].items.blank?
    #      flash[:notice] = t("flash.cart_no_goods_no")
    #      redirect_to cart_path
    #      return
    #    end
  end

  # POST /orders
  # POST /orders.xml
  def create
      @order = Order.new(params[:order])
      if session[:cart].items.blank?
        flash[:notice] = t("flash.cart_no_goods")
        redirect_to cart_path
        return
      end
      session[:cart].items.each do |item|
        @order.order_lines <<  OrderLine.new(
          :product_id =>item.id,
          :color => item.product.color,
          :sort => item.product.price,
          :quantity => item.quantity,
          :price => item.product.price,
          :name=> item.product.name)
      end
     
      if @current_user
        @order.user = current_user
      end
    respond_to do |format|
      if @order.save
        session[:order] = @order
        session[:order_ids] ||= []
        session[:order_ids] << @order.id
        
        flash[:notice] = t"flash.order_create_success"
        format.html { redirect_to(order_path(@order.serial)) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
      p @order.errors
        @order_lines = @order.order_lines
        @province = @order.try(:province)
        @cities = @province.try(:cities)
        @city = @order.try(:city)
        @districts = @city.try(:districts)
        
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end



  # 选择支付页
  def payment
  end

  # 创建支付选择
  def create_payment
    @order = Order.find params[:id]
    @order.payment_id = params[:payment]
    if @order.payment_online?
      @order.payment_commition = 10
    else
      @order.payment_commition = 0
    end
    @order.mailing_commition = 10
    if @order.save
      redirect_to order_path(@order)
    else
      render :action=>:payment
    end
  end

  # 订单确认结果页
  def result
    @order.status = OrderStatus.find 1
    @order.save
#    session[:order] = nil
#    session[:cart].clear!
  end

  private
  def auth_order
    @order = Order.find_by_serial params[:id]
    if session[:order].blank?
      render "error",:layout => false
      return
    end
    unless session[:order] == @order
      unless current_user.blank?
        unless @order.user == current_user
          render "error" ,:layout => false
        end
      else
        render "error",:layout => false
      end
    end
  end

end
