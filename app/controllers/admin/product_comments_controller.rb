# coding: utf-8
class Admin::ProductCommentsController < Admin::BaseController
  # GET /admin_product_comments
  # GET /admin_product_comments.xml
  def index
    @products = Product.find_all_by_user_id(session[:user_id])
    @product_comments = ProductComment.find_all_by_product_id(@products.map(&:id)).paginate(:page => params[:page],
      :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_product_comments }
    end
  end

  # GET /admin_product_comments/1
  # GET /admin_product_comments/1.xml
  def show
    @product_comment = Admin::ProductComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_comment }
    end
  end

  # GET /admin_product_comments/new
  # GET /admin_product_comments/new.xml
  def new
    @product_comment = Admin::ProductComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_comment }
    end
  end

  # GET /admin_product_comments/1/edit
  def edit
    @product_comment = Admin::ProductComment.find(params[:id])
  end

  # POST /admin_product_comments
  # POST /admin_product_comments.xml
  def create
    @product_comment = Admin::ProductComment.new(params[:product_comment])

    respond_to do |format|
      if @product_comment.save
        flash[:notice] = 'Admin::ProductComment was successfully created.'
        format.html { redirect_to(@product_comment) }
        format.xml  { render :xml => @product_comment, :status => :created, :location => @product_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_product_comments/1
  # PUT /admin_product_comments/1.xml
  def update
    @product_comment = Admin::ProductComment.find(params[:id])

    respond_to do |format|
      if @product_comment.update_attributes(params[:product_comment])
        flash[:notice] = 'Admin::ProductComment was successfully updated.'
        format.html { redirect_to(@product_comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_product_comments/1
  # DELETE /admin_product_comments/1.xml
  def destroy
    @product_comment = Admin::ProductComment.find(params[:id])
    @product_comment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_product_comments_url) }
      format.xml  { head :ok }
    end
  end
end
