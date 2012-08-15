# coding: utf-8
class Admin::ArticlesController < Admin::BaseController

  # GET /admin_articles
  # GET /admin_articles.xml
  def index
    @search = Article.search(params[:search])
#    unless params[:title].blank?
#      title = split_keyword(params[:title])
#      @search.conditions.title_like = title
#    end
#    unless params[:subhead].blank?
#      subhead = split_keyword(params[:subhead])
#      @search.conditions.subhead_like = subhead
#    end
#    unless params[:from].blank?
#      from = split_keyword(params[:from])
#      @search.conditions.from_like = from
#    end
#    unless params[:author].blank?
#      author = split_keyword(params[:author])
#      @search.conditions.author_like = author
#    end
#    unless params[:user].blank?
#      user = split_keyword(params[:user])
#      @search.user.name_like  = user
#    end
#    unless params[:body].blank?
#      body = split_keyword(params[:body])
#      @search.conditions.body_like = body
#    end
#    unless params[:keywords].blank?
#      keywords = split_keyword(params[:keywords])
#      keywords.each do |keyword|
#        unless keyword.blank?
#          @search.conditions.group do |g|
#            g.or_title_like = keyword
#            g.or_subhead_like = keyword
#            g.or_from_like = keyword
#            g.or_author_like = keyword
#            g.or_body_like = keyword
#            g.or_body_contains  = keyword
#            g.category.or_name_contains = keyword
#            g.user.or_name_contains = keyword
#            g.user.or_mobile_contains = keyword
#            g.user.or_phone_contains = keyword
#            g.user.or_email_contains = keyword
#            g.user.province.or_name_contains = keyword
#          end
#        end
#      end
#    end

      @articles = @search.page(params[:page]||1).per(20)
   

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /admin_articles/1
  # GET /admin_articles/1.xml
  def show
    @article = Article.find(params[:id])
    @article_image =  ArticleImage.new
    @article_comments =  @article.article_comments.paginate(:page => params[:page] , :per_page => 20)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /admin_articles/new
  # GET /admin_articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /admin_articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /admin_articles
  # POST /admin_articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        unless params[:image].blank?
          params[:image].each do |i|
            @article.article_images << ArticleImage.create(:image=>i)
          end
        end
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to edit_admin_article_path(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_articles/1
  # PUT /admin_articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        unless params[:image].blank?
          params[:image].each do |i|
            @article.article_images << ArticleImage.create(:image=>i)
          end
        end
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to  edit_admin_article_path(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_articles/1
  # DELETE /admin_articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(admin_articles_url) }
      format.xml  { head :ok }
    end
  end
  
  
     
  def upload
    @article_image = ArticleImage.new(params[:article_image])
    respond_to do |format|
      if @article_image.save
        flash[:notice] = '上传成功！'
        format.html { redirect_to admin_article_path(@article_image.article_id) }
        format.xml  { render :xml => @article_comments, :status => :created, :location => @article_comments }
      else
        flash[:error] = '上传失败！'
        format.html { redirect_to admin_article_path(@article_image.article_id) }
        format.xml  { render :xml => @article_comments.errors, :status => :unprocessable_entity }
      end
    end
  end 
end
