# coding: utf-8
class ForgottenPasswordsController < ApplicationController

  def new
    @forgotten_password = ForgottenPassword.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forgotten_password }
    end
  end

  def create
    @forgotten_password = ForgottenPassword.new(params[:forgotten_password])
    @forgotten_password.user = User.find_by_email(@forgotten_password.email)
    
    respond_to do |format|
      if @forgotten_password.save
        ForgottenPasswordMailer.deliver_forgot_password(@forgotten_password)
        flash[:notice] = "链接已发至#{@forgotten_password.email}，请注意查收！."
        format.html { redirect_to '/' }
        format.xml  { render :xml => @forgotten_password, :status => :created, :location => @forgotten_password }
      else
        # use a friendlier message than standard error on missing email address
        if @forgotten_password.errors.on(:user)
          @forgotten_password.errors.clear
          flash[:error] = "您的邮箱不存在，请注册或联系管理员！"
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @forgotten_password.errors, :status => :unprocessable_entity }
      end
    end
  end

  def reset
    begin
      @user = ForgottenPassword.find(:first, :conditions => ['reset_code = ? and expiration_date > ?', params[:reset_code], Time.now]).user
    rescue
      flash[:notice] = '您的链接已过期！'
      redirect_to(new_forgotten_password_path)
    end    
  end

  def update_after_forgetting
    @forgotten_password = ForgottenPassword.find_by_reset_code(params[:reset_code])
    @user = @forgotten_password.user unless @forgotten_password.nil?
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
       @forgotten_password.destroy
        PasswordMailer.deliver_reset_password(@user)
        ForgottenPasswordMailer.deliver_reset_password(@user)
        flash[:notice] = "修改成功，请登陆！"
        format.html { redirect_to login_path}
      else
        flash[:notice] = '修改失败，请重试或联系管理员！'
        format.html { render :action => :reset, :reset_code => params[:reset_code] }
      end
    end
  end
  
end
