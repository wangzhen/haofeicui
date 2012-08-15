# == Schema Information
#
# Table name: roles
#
#  id          :integer(4)      not null, primary key
#  name        :string(40)      not null
#  description :string(255)     not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Role < ActiveRecord::Base
    has_many :roles_users , :class_name => "RolesUser" ,:foreign_key => :role_id,:dependent => :destroy
    has_many :users  ,:through=>:roles_users ,:source => :user,:class_name => "User"
    has_many :permissions_roles , :class_name => "PermissionsRole" ,:foreign_key => :role_id,:dependent => :destroy
    has_many :permissions ,:through=>:permissions_roles ,:source => :permission,:class_name => "Permission"


  validates_presence_of :name
  validates_length_of       :name,        :maximum => 50  , :allow_nil => true
end
