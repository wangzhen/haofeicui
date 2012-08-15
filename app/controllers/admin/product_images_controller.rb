# coding: utf-8
class Admin::ProductImagesController < ApplicationController
  # GET /admin_product_images
  # GET /admin_product_images.xml
  def index
    @admin_product_images = ProductImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_product_images }
    end
  end

  # GET /admin_product_images/1
  # GET /admin_product_images/1.xml
  def show
    @product_image = ProductImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_image }
    end
  end

  # GET /admin_product_images/new
  # GET /admin_product_images/new.xml
  def new
    @product_image = Admin::ProductImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_image }
    end
  end

  # GET /admin_product_images/1/edit
  def edit
    @product_image = Admin::ProductImage.find(params[:id])
  end

  # POST /admin_product_images
  # POST /admin_product_images.xml
  def create
    @product_image = ProductImage.new(params[:product_image])
    #    @product = Product.find([:product_id])
    respond_to do |format|
      if @product_image.save
        @product_image.sort = ProductImage.find_all_by_product_id(params[:product_image][:product_id]).size
        @product_image.save
        flash[:notice] = 'ProductImage was successfully created.'
        format.html { redirect_to( admin_product_path(params[:product_image][:product_id])) }
      else
        flash[:notice] = "图片过大式图片格式不正确.#{@product_image.errors}"
        format.html { redirect_to( admin_product_path(params[:product_image][:product_id])) }

      end
    end
  end

  # PUT /admin_product_images/1
  # PUT /admin_product_images/1.xml
  def update
    @product_image = Admin::ProductImage.find(params[:id])

    respond_to do |format|
      if @product_image.update_attributes(params[:product_image])
        flash[:notice] = 'Admin::ProductImage was successfully updated.'
        format.html { redirect_to(@product_image) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_product_images/1
  # DELETE /admin_product_images/1.xml
  def destroy
    @product_image = ProductImage.find(params[:id])
    @product_image.destroy

    respond_to do |format|
        format.html { redirect_to( edit_admin_product_path(params[:product_id])) }
      format.xml  { head :ok }
    end
  end
end
