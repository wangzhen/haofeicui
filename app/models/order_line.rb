# coding: utf-8
# == Schema Information
#
# Table name: order_lines
#
#  id         :integer(4)      not null, primary key
#  order_id   :integer(4)
#  product_id :integer(4)
#  name       :string(255)
#  sort       :string(255)
#  color      :string(255)
#  quantity   :integer(4)
#  price      :integer(4)
#  remark     :text
#  created_at :datetime
#  updated_at :datetime
#

class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_presence_of :name ,:message =>  I18n.t("activerecord.errors.messages.blank")
  #  validates_presence_of :sub_name ,:message => I18n.t("activerecord.errors.messages.blank")
  validates_presence_of :quantity,:message => I18n.t("activerecord.errors.messages.blank")
  #  validates_presence_of :price,:message => I18n.t("activerecord.errors.messages.blank")
  
  #  validates_numericality_of :price,:message => I18n.t("activerecord.errors.messages.not_a_number")
  validates_numericality_of :quantity,:message => I18n.t("activerecord.errors.messages.not_a_number")


  before_save :set_product

  def subtotal
    price * quantity
  rescue
    0.0
  end

  private
  def set_product
    self.price = self.product.price unless self.product.blank?
    self.name = self.product.name unless self.product.blank?
    self.sort = self.product.sort.name unless self.product.blank?
    self.color = self.product.color.name unless self.product.blank?
    self.remark = self.product.introduction unless self.product.blank?

  end

end
