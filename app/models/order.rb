# == Schema Information
#
# Table name: orders
#
#  id                     :integer(4)      not null, primary key
#  user_id                :integer(4)
#  status                 :integer(4)      default(1)
#  serial                 :string(255)
#  subtotal               :integer(4)
#  total                  :integer(4)
#  adjustment             :integer(4)
#  mailing_commition      :integer(4)
#  payment                :integer(4)
#  user_name              :string(255)
#  mailing_id             :integer(4)
#  delivery_schedule_date :date
#  delivery_serial        :string(255)
#  completed_on           :date
#  province_id            :integer(4)
#  city_id                :integer(4)
#  district_id            :integer(4)
#  address                :string(255)
#  postal_code            :string(255)
#  phone                  :string(255)
#  mobile                 :string(255)
#  email                  :string(255)
#  user_remark            :string(255)
#  admin_remark           :string(255)
#  deleted_at             :datetime
#  fax                    :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class Order < ActiveRecord::Base
  Status = {1 => '等待买家支付' ,   
    2 => '等待卖家发货' , 
    3 => '等待卖家发货' ,    
    4 => '已发货-等待买家确认' ,  
    5 => '交易完成'     }
  
  default_scope :order => 'created_at DESC'
  named_scope :status ,:conditions=>["status is not null"]
  # 关系
  belongs_to :user
  belongs_to :mailing   # 邮寄类型
  belongs_to :province
  belongs_to :city
  belongs_to :district
  belongs_to :delivery_schedule
  has_many :order_lines,:dependent => :destroy
  accepts_nested_attributes_for :order_lines
  # 校验
  validates_associated :order_lines
  #  validates_presence_of :status_id,:message => I18n.t("activerecord.errors.messages.blank")
#  validates_presence_of :subtotal,:message => I18n.t("activerecord.errors.messages.blank")
#  validates_presence_of :total,:message => I18n.t("activerecord.errors.messages.blank")
#  validates_presence_of :user_name,:message => I18n.t("activerecord.errors.messages.blank"),:if => Proc.new{|o| o.user_id.blank?}
#  validates_presence_of :province_id,:message => I18n.t("activerecord.errors.messages.blank")
#  validates_presence_of :city_id ,:message => I18n.t("activerecord.errors.messages.blank")
#  validates_presence_of :address,:message => I18n.t("activerecord.errors.messages.blank")
#
#  validates_presence_of :phone,:message => "电话和手机必需填写一个",:if=>Proc.new{|u| u.mobile.blank?}
#  validates_presence_of :mobile,:message => "电话和手机必需填写一个",:if=>Proc.new{|u| u.phone.blank?}
#
#  validates_numericality_of :total,:message => I18n.t("activerecord.errors.messages.not_a_number"), :less_than=>9999999999.99
#  validates_numericality_of :adjustment,:message => I18n.t("activerecord.errors.messages.not_a_number"),:allow_nil => true, :less_than=>9999999999.99
#  validates_numericality_of :mailing_commition,:message => I18n.t("activerecord.errors.messages.not_a_number"),:allow_nil => true, :less_than=>9999999999.99
#
#  validates_length_of       :phone,:within => 5..30,:if=>Proc.new{|u| u.mobile.blank? or !u.phone.blank?}
#  validates_length_of       :mobile,:within => 5..12,:if=>Proc.new{|u| u.phone.blank? or !u.mobile.blank?}
#  validates_length_of       :admin_remark ,:within => 1..200,:allow_blank => true,:tokenizer => lambda {|str| str.scan(/[^\r\n]/)}
#  validates_length_of       :user_remark ,:within => 1..200, :allow_blank => true,:tokenizer => lambda {|str| str.scan(/[^\r\n]/)}
#  validates_format_of       :email,    :with => Authentication.email_regex,:allow_blank => true

  def validate
    #    if order_lines.blank?
    #      errors.add_to_base("没有选择产品!")
    #    end
  end

  # 回调

  #  before_save :calculate
  #  before_update :calculate
  before_save :calculate
  before_update :calculate
  before_create :set_default_attrs
  after_create :generate_serial
  before_validation :calculate



  def full_city_name
    [self.try(:province).try(:name),self.try(:city).try(:name),self.try(:district).try(:name)] * " "
  end

  def delivery_schedule_time
    self.try(:delivery_schedule).try(:name)
  end

  
  def shipping_charge
    mailing  = self.mailing_commition.blank? ? 0.00 : self.mailing_commition.to_f
    return  mailing
  end

  def subtotal
    return order_lines.inject(0) { |sum, line| sum + line.subtotal }
  end



  protected
  # Set default attributes for current order
  def set_default_attrs
    #    self.ordered_on ||= Time.now.to_date
  end
  def calculate
    if self.order_lines.blank?
      self.total = 0
    else
      self.total = self.subtotal.to_f + self.shipping_charge.to_f + self.adjustment.to_f
    end
    
  end


  def generate_serial
    self.serial = Time.now.strftime('%Y%m%d') + ("%06d" % self.id)
    self.save
  end
end
