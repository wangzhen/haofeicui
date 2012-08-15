# coding: utf-8
class Admin::ProductsController < Admin::BaseController
  # GET /admin_products
  # GET /admin_products.xml
  def index

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
#    unless params[:introduction].blank?
#      introduction = split_keyword(params[:introduction])
#      @search.conditions.introduction_like = introduction
#    end
#
    @products = @search.page(params[:page]||1).per(20).order('id desc')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
end

  # GET /admin_products/1
  # GET /admin_products/1.xml
  def show
    @product =  Product.find_by_id(params[:id])
    @production_image = ProductImage.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
      format.js{
        render :json => @product.to_json(:include=>[:sort,:color])
      }
    end
  end

  # GET /admin_products/new
  # GET /admin_products/new.xml
  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /admin_products/1/edit
  def edit
    @product =  Product.find_by_id(params[:id])
  end

  # POST /admin_products
  # POST /admin_products.xml
  def create
    @product = Product.new(params[:product])
    #    @product.user_id = session[:user_id]
    respond_to do |format|
      if @product.save
        unless params[:image].blank?
          params[:image].each do |i|
            @product.product_images << ProductImage.create(:image=>i)
          end
        end
        flash[:notice] = 'Admin::Product was successfully created.'
        format.html { redirect_to admin_product_path(@product) }

        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_products/1
  # PUT /admin_products/1.xml
  def update
    @product = Product.find_by_id(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        unless params[:image].blank?
          params[:image].each do |i|
            @product.product_images << ProductImage.create(:image=>i)
          end
        end
        flash[:notice] = 'Admin::Product was successfully updated.'
        format.html { redirect_to(:action => "edit" ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_products/1
  # DELETE /admin_products/1.xml
  def destroy
    @product =  Product.find_by_id(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(admin_products_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def select
    @search = Product.new_search(params[:search])
    @products = @search.all.paginate(:page => params[:page],:per_page => 50)
  end
  
end

