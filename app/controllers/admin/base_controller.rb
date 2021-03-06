# coding: utf-8
class Admin::BaseController < ApplicationController
  
  layout   'admin/base'

  before_filter :admin_authorize
#  include AuthenticatedSystem
  #
  #    protected
  #
  #  ssl_required :admin_authorize if SSL_ENABLE
  def admin_authorize
    if session[:admin]
      return true
    else
      redirect_to new_admin_session_path
      return false
    end
  end


  def split_keyword(keyword)
    unless keyword.blank?
      keyword.gsub!(/[　\s\t]+$/o, "")
      keyword.gsub!(/^[　\s\t]+/o, "")
      keyword.gsub!(/[　\s\t]+/o, " ")
      keyword.split(/(\s)/)
    end
  end
end

