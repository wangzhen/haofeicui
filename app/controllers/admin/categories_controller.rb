# coding: utf-8
class Admin::CategoriesController < Admin::BaseController

  # GET /admin_categories
  # GET /admin_categories.xml

  def index
    @categories = Category.all
 @category = Category.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_categories }
    end
  end

  # GET /admin_categories/1
  # GET /admin_categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /admin_categories/new
  # GET /admin_categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /admin_categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /admin_categories
  # POST /admin_categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(admin_categories_path) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_categories/1
  # PUT /admin_categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to( admin_categories_path ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_categories/1
  # DELETE /admin_categories/1.xml
  def destroy
    @category = Category.find(params[:id])
#    @category.destroy

    respond_to do |format|
      format.html { redirect_to(admin_categories_url) }
      format.xml  { head :ok }
    end
  end
end