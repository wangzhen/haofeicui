# coding: utf-8
class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem


  # render new.rhtml
  def new
    @user = User.new
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      #      redirect_back_or_default('/')
      redirect_to '/'
      flash[:notice] = "谢谢您的注册!"
    else
#      @cities = @user.try(:province).try(:cities)
#      @districts = @user.try(:city).try(:districts)
      flash[:error]  = "注册失败！请检查您的填写信息或与管理员联系！"
      render :action => 'new'
    end
  end
  def edit
    @user = current_user
    if @user.blank?
      redirect_to login_path
    end
    @cities = @user.try(:province).try(:cities)
    @districts = @user.try(:city).try(:districts)
  end

  
  def update
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update_attributes(params[:user])
        UserMailer.deliver_user_update(@user) 
        #        UserMailer.deliver_user_update(@user)
        flash[:notice] = '信息修改成功！'
        format.html    { redirect_to edit_user_path }
        format.xml  { head :ok }
      else
        @cities = @user.try(:province).try(:cities)
        @districts = @user.try(:city).try(:districts)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end

  end

  
  #激活用户
  def activate
    @html_title = "激活用户"
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      #          flash[:notice] = "Signup complete! Please sign in to continue."
      flash[:notice] = "激活成功！"
      redirect_to login_path
    when params[:activation_code].blank?
      #          flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      flash[:error] = "激活码不存在！"
      #          redirect_back_or_default('/')
      redirect_to login_path
    else
      flash[:error]  = "flash.haveactivated"
      #          redirect_back_or_default('/')
      redirect_to login_path
    end

  end
  
  def show
    @user = User.find_by_id(params[:id].to_i)
   @user0 = User.find(:all , :conditions => ["id  < ?" ,params[:id].to_i] ,:limit => 1)  
    @user2 = User.find(:all , :conditions => ["id  > ?" ,params[:id].to_i] ,:limit =>1)  
    @title = @user.name
    @keywords =  @user.name
    @description =  @user.introduction
  end


end
