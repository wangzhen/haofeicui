# coding: utf-8
class AjaxesController < ApplicationController
#    ssl_allowed :province_select,:city_select,:category_select,
#      :product_decided_by_category_select,:copy_user_info,:delete_product_picture,
#      :icon_preview ,:change_product_is_public, :category_sort , :change_category_is_public ,
#      :set_recomm_product if SSL_ENABLE

  def province_select
    begin
      model = params[:model]
      name = params[:name]
      search = params[:search]
      district_id = params[:district_id]
      city_id = params[:city_id]
      replace_city_id = params[:replace_city_id]
      replace_district_id =params[:replace_district_id]
      province = Province.find_by_id(params[:province_id]) unless  params[:province_id].blank?
    rescue =>e
      province =nil
    end

    @cities = province.try(:cities)
    render :update do |page|
      page.replace replace_city_id,:partial=>"/shared/city_select" , :locals=>{:model=>model ,  :cities=>@cities ,:options =>{:name=>city_id,:search=>search},:html_options =>{}}
      page.replace replace_district_id,:partial=>"/shared/district_select" , :locals=>{:model=>model , :districts=>@districts ,:options =>{:name=>district_id,:search=>search},:html_options =>{}}
    end
  end


  def city_select
    begin
      model = params[:model]
      district_id = params[:district_id]
      replace_district_id =params[:replace_district_id]
      city = City.find_by_id(params[:city_id]) unless params[:city_id].blank?
    rescue =>e
      city =nil
    end
    @districts = city.try(:districts)
    render :update do |page|
       page.replace replace_district_id,:partial=>"shared/district_select" , :locals=>{:model=>model, :districts=>@districts ,:options =>{:name=>district_id },:html_options =>{}}
     end
        
  end

  #产品分类
  def category_select
    begin
      obj = params["object"]
      @categories =  Category.find(params[:category_id]).children
    rescue =>e
      @categories =nil
    end
    
    render :update do |page|
      if @categories.blank?
        page.replace("category_children"  ,  "<a  style='background:transparent none no-repeat scroll center center;' id ='category_children'></a>")
      else
        page.replace("category_children"  , :partial => "/shared/category_children" , :locals=>{:categories=>@categories,:object=>obj})
      end
    end
  end

  def product_decided_by_category_select
    @category = Category.find(params[:subcategory_id])
    @products_decided_by_category = @category.products
    render :update do |page|
      page.replace("recommendation_product_id",:partial=>"/shared/categoried_products",:locals=>{:products_decided_by_category => @products_decided_by_category})
    end

  end

  def copy_user_info
    render :update do |page|
      if params[:user_id].blank?
        page.alert("还未选择用户!")
        return
      end
      @user = User.find(params[:user_id])
      case params[:type]
      when "r"  # 更新发件人信息
        page["order_user_name"].value = @user.name
        page["order_province_id"].value = @user.try(:province).try(:id)
        province = @user.try(:province)
        city = @user.try(:city)
        cities = province.try(:cities)
        districts = city.try(:districts)
        page.replace "order_city_id",:partial=>"shared/city_select" , :locals=>{:cities=>cities,:object=>"order", :replace_name=>"order"}
        page.replace "order_district_id",:partial=>"shared/district_select" , :locals=>{:districts=>districts,:object=>"order" , :replace_name=>"order"}
        page["order_city_id"].value = @user.try(:city).try(:id)
        page["order_district_id"].value = @user.try(:district).try(:id)
        page["order_address"].value = @user.address
        page["order_tel"].value = @user.tel
        page["order_mobile"].value = @user.mobile
        page["order_fax"].value = @user.fax
        page["order_postal_code"].value = @user.postal_code
        page["order_email"].value = @user.email
      when "s" # 更新收件人信息
        page["order_sender_user_name"].value = @user.name
        page["order_sender_province_id"].value = @user.try(:province).try(:id)
        province = @user.try(:province)
        city = @user.try(:city)
        cities = province.try(:cities)
        districts = city.try(:districts)
        page.replace "order_sender_city_id",:partial=>"shared/city_select" , :locals=>{:cities=>cities,:object=>"order", :replace_name=>"order_sender"}
        page.replace "order_sender_district_id",:partial=>"shared/district_select" , :locals=>{:districts=>districts,:object=>"order" , :replace_name=>"order_sender"}
        page["order_sender_city_id"].value = @user.try(:city).try(:id)
        page["order_sender_district_id"].value = @user.try(:district).try(:id)
        page["order_sender_address"].value = @user.address
        page["order_sender_tel"].value = @user.tel
        page["order_sender_mobile"].value = @user.mobile
        page["order_sender_fax"].value = @user.fax
        page["order_sender_postal_code"].value = @user.postal_code
        page["order_sender_email"].value = @user.email
      end
    end
   
  rescue Exception =>e
    render :update do |page|
      page.alert("非法用户!")
    end
  end

  def delete_product_image
    picture = ProductImage.find params[:p_id]
    remove_id = "picture_"+picture.id.to_s
    picture.destroy
    render :update do |page|
      page.remove remove_id
    end
  end
  
  def delete_article_image
    artilce = ArtcletImage.find params[:p_id]
    remove_id = "picture_"+artilce.id.to_s
    artilce.destroy
    render :update do |page|
#      page.remove remove_id
      page.refresh
    end
  end

  # 产品图标预览
  def icon_preview
    icon = ProductIcon.find params[:icon_id]
    render :update do |page|
      page.replace_html "icon_preview",image_tag(icon.picture_name)
    end
  end

  # ajax 更改产品的 is_public 字段
  def change_product_is_public
    product = Product.find params[:product_id]
    case params[:is_public]
    when "true"
      product.is_public = true
    when "false"
      product.is_public = false
    end
    product.save
    render :nothing => true
  rescue ActiveRecord::RecordInvalid => e
    render :update do |page|
      page["product_public_#{product.id}"].value = product.is_public.to_s
      page.alert(e.record.errors.full_messages)
    end
  end

  # ajax 产品分类的排序
  def category_sort
    category = Category.find params[:category_id]
    type = params[:type]
    Category.category_sort(category,params[:sort])
    if type == "root"
      render :update do |page|
        page.redirect_to sort_admin_categories_path
      end
    else
      render :update do |page|
        page.redirect_to sub_sort_admin_category_path(category.parent)
      end
    end
  end
  
  # ajax 产品颜色分类的排序
  def color_sort
    color = Color.find params[:color_id]
    Color.color_sort(color,params[:sort])
#      render :update do |page|
#        page.
          redirect_to(admin_colors_path)
#      end
  end
      # ajax 产品种类分类的排序
 def sort_sort
    sort = Sort.find params[:sort_id]
    Sort.sort_sort(sort,params[:sort])

#      render :update do |page|
#        page.
          redirect_to(admin_sorts_path)
#      end
  end

     # ajax article的排序
 def article_image_sort
    article_image = ArticleImage.find params[:article_image_id]
    ArticleImage.article_image_sort(article_image,params[:article_id] ,params[:sort])
      render :update do |page|
        page.reload
      end

  end

     # ajax 产品种类分类的排序
 def product_image_sort
    product_image = ProductImage.find params[:product_image_id]
    ProductImage.product_image_sort(product_image,params[:product_id] ,params[:sort])
    redirect_to :back
#      render :update do |page|
#        page.reload
#      end

  end
  def change_category_is_public
    category=Category.find(params[:category_id])
    if params[:is_public] == "true"
      category.update_attributes(:is_public =>true )
    else
      category.update_attributes(:is_public => false)
    end
    render :update do |page|

        if category.is_root?
           page.redirect_to(sort_admin_categories_path)
        else
          page.redirect_to(sub_sort_admin_category_path(category.parent))
       end
       
      end
    
    end

    def set_recomm_product
      root = Category.find params[:root_id]
      product = Product.find params[:product_id]
      if params[:recomm_id].nil?
        recomm = Recommendation.create!(:category_id => params[:root_id],:product_id => params[:product_id],:sort => params[:sort])
      else
        recomm = Recommendation.find params[:recomm_id]
        recomm.destroy
        recomm = Recommendation.create!(:category_id => params[:root_id],:product_id => params[:product_id],:sort => params[:sort])
      end

      render :update do |page|
        page.replace "recomm_#{root.id}_#{params[:sort]}" ,:partial => "admin/recommendations/r_list",:locals => {:index=>params[:sort],
          :product => product,:root => root,:recomm => recomm}
        page["recomm_#{root.id}_#{params[:sort]}"].visual_effect :highlight
      end
    rescue Exception =>e
      render :update do |page|
        page["select_product_#{root.id}_#{params[:sort]}"].value = ""
        page.alert e.record.errors.map{|key,value|value}
      end
    end

  end
