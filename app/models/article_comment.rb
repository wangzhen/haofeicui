# coding: utf-8
# == Schema Information
#
# Table name: article_comments
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  ipaddr     :string(255)
#  user_id    :integer(4)
#  article_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class ArticleComment < ActiveRecord::Base
  belongs_to :article
end
