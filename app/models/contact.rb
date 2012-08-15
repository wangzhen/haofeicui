# coding: utf-8
# == Schema Information
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  serial     :string(255)
#  phone      :string(255)
#  name       :string(255)
#  email      :string(255)
#  qq         :string(255)
#  content    :string(255)
#  reply      :string(255)
#  ipaddr     :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
#  include Authentication
  before_create :set_serial
  validates_presence_of :email 
  validates_presence_of :content
#  validates_format_of :email, :with => Authentication.email_regex, :message => '邮件必须是正确格式'
  
  def set_serial
    self.serial = Time.now.strftime("%Y%m%d%H#{rand(9)}#{rand(9)}")
  end
end
