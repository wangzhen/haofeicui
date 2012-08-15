class Member::BaseController < ApplicationController
  
#  layout   'admin/base'

  before_filter :user_authorize
#  include AuthenticatedSystem
  #
  #    protected
  #
  #  ssl_required :admin_authorize if SSL_ENABLE
  def user_authorize
    if session[:user_id]
      return true
    else
      redirect_to new_session_path
      return false
    end
  end


  def split_keyword(keyword)
    unless keyword.blank?
#      keyword.gsub!(/[　\s\t]+$/o, "")
#      keyword.gsub!(/^[　\s\t]+/o, "")
#      keyword.gsub!(/[　\s\t]+/o, " ")
#      keyword.split(/(\s)/)
    end
  end
end

