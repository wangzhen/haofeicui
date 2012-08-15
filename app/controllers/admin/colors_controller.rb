# coding: utf-8
class Admin::ColorsController < Admin::BaseController
  # GET /colors
  # GET /colors.xml
  def index
    @colors = Color.all
    @color = Color.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @colors }
    end
  end

  # GET /colors/1
  # GET /colors/1.xml
  def show
    @color = Color.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @color }
    end
  end

  # GET /colors/new
  # GET /colors/new.xml
  def new
    @color = Color.new


  end

  # GET /colors/1/edit
  def edit
    @color = Color.find(params[:id])
  end

  # POST /colors
  # POST /colors.xml
  def create
    @colors = Color.all
    @color = Color.new(params[:color])

    respond_to do |format|
      if @color.save
        @color.sort = Color.all.size
        @color.save
        flash[:notice] = 'Color was successfully created.'
        format.html {  redirect_to(admin_colors_path)}
        format.xml  { render :xml => @color, :status => :created, :location => @color }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /colors/1
  # PUT /colors/1.xml
  def update
    @colors = Color.all
    @color = Color.find(params[:id])

    respond_to do |format|
      if @color.update_attributes(params[:color])
        flash[:notice] = 'Color was successfully updated.'
        format.html {  redirect_to(admin_colors_path)}
        format.xml  { head :ok }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1
  # DELETE /colors/1.xml
  def destroy
    @color = Color.find(params[:id])
#    @color.destroy

    respond_to do |format|
      format.html { redirect_to(colors_url) }
      format.xml  { head :ok }
    end
  end


  
end
