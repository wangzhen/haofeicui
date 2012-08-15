# coding: utf-8
class Admin::OrdersController < Admin::BaseController

  # GET /orders
  # GET /orders.xml

  def index
    @search = Order.new_search(params[:search])
    unless params[:name].blank?
      name = split_keyword(params[:name])
      @search.conditions.user.name_like = name
    end
    unless params[:serial].blank?
      serial = split_keyword(params[:serial])
      @search.conditions.serial_like = serial
    end
    @orders = @search.all.paginate(:page => params[:page],:per_page => 50)
    @search_order = @orders.first
    unless params[:search].blank?
      unless params[:search][:conditions].blank?
        unless params[:search][:conditions][:province_id_is].blank?
          @province = Province.find(params[:search][:conditions][:province_id_is])
          @cities = @province.try(:cities)
        end
        unless params[:search][:conditions][:city_id_is].blank?
          @city = City.find(params[:search][:conditions][:city_id_is])
          @districts = @city.try(:districts)
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
#      format.pdf do
#        @title = "订单一览表"
#      end
      format.xml  { render :xml => @orders }
#      format.pdf do
#        render
#        headers['Pragma'] = 'public'
#        headers['Cache-Control'] = 'public'
#        filename = "order_" << Time.now.strftime("%Y%m%d_%H%M%S") << ".pdf"
#        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
#      end
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html {render :template => "public/404.html", :layout => false, :status => 404 }# show.html.erb
      format.xml  { render :xml => @order }
      format.pdf do
        render
        headers['Pragma'] = 'public'
        headers['Cache-Control'] = 'public'
        filename = "#{@order.serial}.pdf"
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new(:mailing_commition => "10",:delivery_schedule_date => Time.now.tomorrow)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @province = @order.try(:province)
    @cities = @province.try(:cities)
    @city = @order.try(:city)
    @districts = @city.try(:districts)

  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    remove_line(@order)
    if @order.save
      flash[:notice] = t("flash.saved")
      redirect_to admin_orders_path
    else
      @order_lines = @order.order_lines
      @province = @order.try(:province)
      @cities = @province.try(:cities)
      @city = @order.try(:city)
      @districts = @city.try(:districts)

      @sender_province = @order.try(:sender_province)
      @sender_cities = @sender_province.try(:cities)
      @sender_city = @order.try(:sender_city)
      @sender_districts = @sender_city.try(:districts)
      render "new"
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
    remove_line(@order)
    respond_to do |format|
      if @order.update_attributes(params[:order])
        @order.reload
        @order.save
        flash[:notice] = t("flash.order_create_success")
        format.html { redirect_to(admin_orders_path(:name=>params[:name] , :user_name_show=>params[:user_name_show],:serial=>params[:serial] ,:search=>params[:search])) }
        format.xml  { head :ok }
      else
        format.html {
          @order_lines = @order.order_lines
          @province = @order.try(:province)
          @cities = @province.try(:cities)
          @city = @order.try(:city)
          @districts = @city.try(:districts)
          render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_orders_path(:name=>params[:name] , :user_name_show=>params[:user_name_show],:serial=>params[:serial] ,:search=>params[:search])) }
      format.xml  { head :ok }
    end
  end

  def summary
    @order = Order.find params[:id]
    return false unless request.xhr?
    
  end

  
  private
  def remove_line(order)
    ary = []
    order.order_lines.each_with_index do |line,i|
      ary.push i if line.product_id.nil?
    end
    ary.reverse!
    ary.each do |line|
      order.order_lines.delete_at(line)
    end

  end

end
