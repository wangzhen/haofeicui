# coding: utf-8
class Admin::UsersController < Admin::BaseController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # render new.rhtml
  def new
    @user = User.new
  end
  def index
   
    @search = User.new_search(params[:search])
    unless params[:name].blank?
      name = split_keyword(params[:name])
      @search.conditions.name_like = name
    end
    unless params[:email].blank?
      email = split_keyword(params[:email])
      @search.conditions.email_like = email
    end
    unless params[:nickname].blank?
      nickname = split_keyword(params[:nickname])
      @search.conditions.tel_like = nickname
    end
    unless params[:introduction].blank?
      introduction = split_keyword(params[:introduction])
      @search.conditions.introduction_like = introduction
    end
    unless params[:phone].blank?
      phone = split_keyword(params[:phone])
      @search.conditions.phone_like = phone
    end
    unless params[:mobile].blank?
      mobile = split_keyword(params[:mobile])
      @search.conditions.mobile_like = mobile
    end
    unless params[:address].blank?
      address = split_keyword(params[:address])
      @search.conditions.address_like = address
    end

    unless params[:role].blank?
      #        @search.conditions.group do |group|
      #            group.roles.id = params[:role]
      #          end
      params[:role].each do |role|
        @search.conditions.or_group do |group|
          group.roles.id = role.to_a
        end
      end
    end

    #          unless params[:role_name].blank?
    #          @search.conditions.or_group do |group|
    #             role_name = split_keyword(params[:role_name])
    #            group.roles.name_like = role_name
    #          end
    #       end


    unless params[:search].blank?
      unless params[:search][:conditions].blank?
        unless params[:search][:conditions][:province_id_is].blank?
          @province = Province.find(params[:search][:conditions][:province_id_is])
          @cities = @province.try(:cities)
        end
        unless params[:search][:conditions][:city_id_is].blank?
          @city = City.find(params[:search][:conditions][:city_id_is])
          @districts = @city.try(:districts)
        end
      end
    end
    @users = @search.all.paginate(:page => params[:page],:per_page=>50)
  end

  def create
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_to admin_users_path
      flash[:notice] = "创建成功！"
    else
      @cities = @user.try(:province).try(:cities)
      @districts = @user.try(:city).try(:districts)
      flash[:error]  = "创建失败"
      render :action => 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
    @cities = @user.try(:province).try(:cities)
    @districts = @user.try(:city).try(:districts)
    @roles = Role.all
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #       UserMailer.deliver_signup_notification(@user)
      redirect_to admin_users_path
    else
      @cities = @user.try(:province).try(:cities)
      @districts = @user.try(:city).try(:districts)
      render :action => 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
#    @user.destroy
    render :action => 'index'
  end
  
  def select
    @user = User.new(params[:user])
    params[:user] ? params[:user][:deleted_at] = nil :  params[:user] = {:deleted_at => nil}
    @search = User.new_search(params[:search])
    @search.limit = @search.count

    @search.conditions.deleted_at = "is_null"
    @search.conditions.name_like = params[:user][:name] unless params[:user][:name].blank?
    @search.conditions.and_email_like = params[:user][:email] unless params[:user][:email].blank?
    @search.conditions.and_customer_type_id =  params[:user][:customer_type_id].to_s unless params[:user][:customer_type_id].blank?
    @search.conditions.and_tel_like = params[:user][:tel] unless params[:user][:tel].blank?
    @users_pages = @search.all.in_groups_of(20, false)
  end

end
