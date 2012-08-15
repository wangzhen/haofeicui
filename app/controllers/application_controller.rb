# coding: utf-8
#  Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
#  include AuthenticatedSystem
#  include ExceptionNotifiable
  before_filter :a
  def a
    #       Fetion.add_buddy('15000482567', 'hfchfc888','13482842734')
    #       Fetion.send_sms_to_friends('15000482567', 'hfchfc888','13482842734','1')
    #    Fetion.send_sms_to_self('15000482567', 'hfchfc888','1')

    #  10.times do
    #    p UUID.new.generate
    #  end
    #  UUID.md5_create(UUID_DNS_NAMESPACE, "www.widgets.com")
    #  => #<UUID:0x287576 UUID:3d813cbb-47fb-32ba-91df-831e1593ac29>
    #  UUID.sha1_create(UUID_DNS_NAMESPACE, "www.widgets.com")
    #  => #<UUID:0x2a0116 UUID:21f7f8de-8051-5b89-8680-0195ef798b6a>
    #  UUID.timestamp_create.to_s
    #  => #<UUID:0x2adfdc UUID:64a5189c-25b3-11da-a97b-00c04fd430c8>
    #  UUID.random_create.to_s

  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def split_keyword(keyword)
    unless keyword.blank?
#      keyword.gsub!(/[　\s\t]+$/o, "")
#      keyword.gsub!(/^[　\s\t]+/o, "")
#      keyword.gsub!(/[　\s\t]+/o, " ")
#      keyword.split(/(\s)/)
    end
  end
  
end
