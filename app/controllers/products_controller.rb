# coding: utf-8
class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @title = '世代景星珠宝城 - 好翡翠精品-时尚手镯挂件佛观音等玻璃种好翡翠'
    @keywords ='世代景星珠宝 翡翠 手镯 挂件 佛 观音 玻璃种'
    @description ='世代景星珠宝城专卖时尚手镯挂件佛观音等玻璃种翡翠，并为广大翡翠友提供翡翠交流，出售平台'
#    @search = Product.new_search(params[:search])
    @search = Product.search(params[:search])
#    unless params[:name].blank?
#      name = split_keyword(params[:name])
#      @search.conditions.name_like = name
#    end
#    unless params[:serial].blank?
#      serial = split_keyword(params[:serial])
#      @search.conditions.serial_like = serial
#    end
#    unless params[:proved_serial].blank?
#      proved_serial = split_keyword(params[:proved_serial])
#      @search.conditions.proved_serial_like = proved_serial
#    end
#    @search
#    unless params[:keywords].blank?
#      keywords = split_keyword(params[:keywords])
#      keywords.each do |keyword|
#        unless keyword.blank?
#          @search.conditions.group do |g|
#            g.or_introduction_contains  = keyword
#            g.or_introduction_contains  = keyword
#            g.or_serial_contains  = keyword
#            g.or_proved_serial_contains  = keyword
#            g.sort.or_name_contains = keyword
#            g.color.or_name_contains = keyword
#            g.user.or_name_contains = keyword
#            g.user.or_mobile_contains = keyword
#            g.user.or_phone_contains = keyword
#            g.user.or_email_contains = keyword
#          end
#        end
#      end
#    end
#    @products = @search.all.paginate(:page => params[:page]||1 , :per_page => params[:per_page]||21)
    @products = @search.page(params[:page] || 1).per(10).order('id desc')
    
#    @title = " #{@products.try(:first).try(:color).try(:name)}#{@products.try(:first).try(:name)}#{@products.try(:first).try(:sort).try(:name)}#{params[:keywords]} "
#    @keywords ="#{@products.try(:first).try(:name)} #{@products.try(:first).try(:sort).try(:name)} #{@products.try(:first).try(:color).try(:name)} #{params[:keywords]} "
#    @description ="#{@products.try(:first).try(:color).try(:name)}#{@products.try(:first).try(:name)}#{@products.try(:first).try(:sort).try(:name)}#{params[:keywords]}，#{@products.map(&:name).join(" ")} "
#
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @title = " #{@product.try(:color).try(:name)}-#{@products.try(:name)}-#{@product.try(:sort).try(:name)} "
    @keywords ="#{@product.try(:name)} #{@product.try(:sort).try(:name)} #{@product.try(:color).try(:name)}"
    @description ="#{@product.try(:name)}#{@product.try(:sort).try(:name)}#{@product.try(:color).try(:name)}#{@product.try(:introduction)}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def alipay
    @product = Product.find(params[:id])
    @name = params[:name]
    @zip = params[:zip]
    @phone = params[:phone]
    @adress = params[:adress]
    @mobile = params[:mobile]
  end
  
  def buy
    @product = Product.find(params[:id])
    @title = "购买 #{@product.try(:color).try(:name)}-#{@products.try(:name)}-#{@product.try(:sort).try(:name)} "
    @keywords ="购买 #{@product.try(:name)} #{@product.try(:sort).try(:name)} #{@product.try(:color).try(:name)}"
    @description ="购买 #{@product.try(:name)}#{@product.try(:sort).try(:name)}#{@product.try(:color).try(:name)}#{@product.try(:introduction)}"
  
  end

end

