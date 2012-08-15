# == Schema Information
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  name                      :string(50)
#  email                     :string(50)      default(""), not null
#  crypted_password          :string(255)
#  salt                      :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  activation_code           :string(255)
#  activated_at              :datetime
#  nickname                  :string(50)
#  rank                      :integer(4)      default(0)
#  introduction              :string(255)
#  point                     :integer(4)      default(0)
#  coin                      :integer(4)
#  phone                     :string(20)
#  mobile                    :string(20)
#  address                   :string(100)
#  province_id               :integer(4)
#  city_id                   :integer(4)
#  district_id               :integer(4)
#  state                     :integer(4)      default(0)
#  image_file_name           :string(50)
#  image_content_type        :string(255)
#  image_file_size           :integer(4)
#  image_updated_at          :datetime
#

require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  #  has_many :roles_users , :class_name => "RolesUser" ,:foreign_key => :user_id,:dependent => :destroy
  #  has_many :roles ,:through=>:roles_users ,:source => :role,:class_name => "Role"
  belongs_to :province
  belongs_to :city
  belongs_to :district
#  has_many :products ,:dependent => :destroy
  has_many :product_contacts ,:dependent => :destroy
  has_many :product_comments ,:dependent => :destroy
  #  validates_presence_of     :login
  #  validates_length_of       :login,    :within => 3..40
  #  validates_uniqueness_of   :login
  #  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message
  validates_presence_of     :email  ,:on=>:create
  validates_presence_of  :password ,:on=>:create
  
  validates_presence_of      :name ,:on => :update
  validates_presence_of  :phone  , :mobile  , :nickname ,:introduction  , :on=>:update
  
  validates_format_of       :email,    :with => Authentication.email_regex
  validates_format_of       :name,     :with => Authentication.name_regex,  :allow_nil => true

  
  validates_length_of       :phone,       :maximum => 20  , :allow_nil => true 
  validates_length_of       :mobile,      :maximum => 20  , :allow_nil => true
  validates_length_of       :email,       :maximum => 50 , :allow_blank =>true 
  validates_length_of       :name,        :maximum => 50  , :allow_nil => true
  validates_length_of       :nickname,    :maximum => 50  , :allow_nil => true
  validates_length_of       :address,     :maximum => 100  , :allow_nil => true
  validates_length_of       :introduction,:maximum => 255  , :allow_nil => true

  validates_uniqueness_of   :email



  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  #  attr_accessible :email, :name, :password, :password_confirmation ,
  #    :address, :province_id, :district_id, :nickname, :mobile,
  #    :phone, :city_id, :introduction ,:role_ids ,:image
  before_create :make_activation_code

  
  #  # 安全属性
  #  attr_protected :salt, :crypted_password,
  #    :remember_token, :remember_token_expires_at, :activation_code, :activated_at

  has_attached_file :image,
    :url => '/system/users/:id/:style.:extension',
    :path => ':rails_root/public/system/users/:id/:style.:extension',
    :styles => {
    :orignial => "600x600>",
    :small => '128x128>'
  },
    :default_style => :small

  #  user = User.first
  #File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
  #user.save
  #  validates_attachment_presence :image
  #  validates_attachment_size :image, :less_than => 5.megabytes
  #  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png','image/pjpeg' ,'image/x-png' ]
  validates_attachment_content_type :image, :content_type => ["image/jpeg","image/x-png" ,"image/pjpeg","image/gif","image/jpg" , "image/png"  ]
  #      :url => '/system/pictures/:id/:style.:extension',
  #    :path => ':rails_root/public/system/pictures/:id/:style.:extension',
  #    :styles => { :ranking => "129x86>",:item => "160x107>", :small => '110x73>',:big => '240x240>',
  #    :category => "220x164",
  #    :product => "370x277" },
  #    :default_style => :small
  #  validates_attachment_presence :image

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end
  protected

  def make_activation_code
    self.activation_code = self.class.make_token
  end

  #  def set_default_attrs
  #    self.joined_on ||= Time.now
  #  end



end
