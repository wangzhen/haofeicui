# coding: utf-8
class Admin::ArticleCommentsController < Admin::BaseController
  # GET /admin_article_comments
  # GET /admin_article_comments.xml
  def index
    @admin_article_comments = Admin::ArticleComments.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_article_comments }
    end
  end

  # GET /admin_article_comments/1
  # GET /admin_article_comments/1.xml
  def show
    @article_comments = Admin::ArticleComments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article_comments }
    end
  end

  # GET /admin_article_comments/new
  # GET /admin_article_comments/new.xml
  def new
    @article_comments = Admin::ArticleComments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article_comments }
    end
  end

  # GET /admin_article_comments/1/edit
  def edit
    @article_comments = Admin::ArticleComments.find(params[:id])
  end

  # POST /admin_article_comments
  # POST /admin_article_comments.xml
  def create
    @article_comments = Admin::ArticleComments.new(params[:article_comments])

    respond_to do |format|
      if @article_comments.save
        flash[:notice] = 'Admin::ArticleComments was successfully created.'
        format.html { redirect_to(@article_comments) }
        format.xml  { render :xml => @article_comments, :status => :created, :location => @article_comments }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article_comments.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_article_comments/1
  # PUT /admin_article_comments/1.xml
  def update
    @article_comments = Admin::ArticleComments.find(params[:id])

    respond_to do |format|
      if @article_comments.update_attributes(params[:article_comments])
        flash[:notice] = 'Admin::ArticleComments was successfully updated.'
        format.html { redirect_to(@article_comments) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article_comments.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_article_comments/1
  # DELETE /admin_article_comments/1.xml
  def destroy
    @article_comments = Admin::ArticleComments.find(params[:id])
    @article_comments.destroy

    respond_to do |format|
      format.html { redirect_to(admin_article_comments_url) }
      format.xml  { head :ok }
    end
  end
end
