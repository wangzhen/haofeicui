# coding: utf-8
class Admin::SortsController < Admin::BaseController
  # GET /admin_sorts
  # GET /admin_sorts.xml
  def index
    @sorts = Sort.all
    @sort = Sort.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_sorts }
    end
  end

  # GET /admin_sorts/1
  # GET /admin_sorts/1.xml
  def show
    @sort = Sort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sort }
    end
  end

  # GET /admin_sorts/new
  # GET /admin_sorts/new.xml
  def new
    @sort = Sort.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sort }
    end
  end

  # GET /admin_sorts/1/edit
  def edit
    @sort =  Sort.find(params[:id])
  end

  # POST /admin_sorts
  # POST /admin_sorts.xml
  def create
    @sorts = Sort.all
    @sort =  Sort.new(params[:sort])

    respond_to do |format|
      if @sort.save
        flash[:notice] = ' Sort was successfully created.'
        format.html { redirect_to admin_sorts_path }
        format.xml  { render :xml => @sort, :status => :created, :location => @sort }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @sort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_sorts/1
  # PUT /admin_sorts/1.xml
  def update
    @sorts = Sort.all
    @sort =  Sort.find(params[:id])

    respond_to do |format|
      if @sort.update_attributes(params[:sort])
        flash[:notice] = ' Sort was successfully updated.'
        format.html { redirect_to admin_sorts_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @sort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_sorts/1
  # DELETE /admin_sorts/1.xml
  def destroy
    @sort =  Sort.find(params[:id])
#    @sort.destroy

    respond_to do |format|
      format.html { redirect_to(admin_sorts_url) }
      format.xml  { head :ok }
    end
  end
end

