# coding: utf-8
class Admin::ArticleImagesController < Admin::BaseController

  # DELETE /admin_article_comments/1
  # DELETE /admin_article_comments/1.xml
  def destroy
    @article_image = ArticleImage.find(params[:id])
    @article_image.destroy
    respond_to do |format|
#      format.html { redirect_to(admin_article_url(@article_image.article_id)) }
      format.html { redirect_to(edit_admin_article_url(@article_image.article_id)) }
      format.xml  { head :ok }
    end
  end
end
