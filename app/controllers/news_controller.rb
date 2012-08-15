# coding: utf-8
class NewsController < ApplicationController
  # GET /admin_articles
  # GET /admin_articles.xml
  def index
    @search = Article.search(params[:search])
#    unless params[:title].blank?
#      title = split_keyword(params[:title])
#      @search.conditions.title_like = title
#    end
#    unless params[:category_id].blank?
#      @search.conditions.category_id_is = params[:category_id]
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
    @article_comment = @article.article_comments.new(params[:article_comment])
    @article_comments =  @article.article_comments.page(params[:page]||1).per(20)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # POST /admin_articles
  # POST /admin_articles.xml
  def create
    @article_comment = ArticleComment.new(params[:article_comment])
    

    respond_to do |format|
      @article_comment.user_id = session[:user_id]
      if @article_comment.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to news_path(@article_comment.article_id) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        @article = Article.find(@article_comment.article_id)
        @article_comments =  @article.article_comments.paginate(:page => params[:page] , :per_page => 20)
        format.html { render :action => :show }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end



end
