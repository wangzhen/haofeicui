# coding: utf-8
class HomeController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  def index
    ids = %W(1 2 3 4 5 6 7 8 9 9 10 11)
    five_ids = []
    while five_ids.size != 9
      five_ids << ids.rand.to_i
      five_ids.uniq!
    end
    @products = Product.find(:all ,:conditions => ["id in (?)" ,five_ids],:order => 'id desc' ,:limit => 9)
    @sorts = Sort.find(:all)
    @colors = Color.find(:all)
    @title = '世代景星珠宝城 - 翡翠精品-时尚手镯挂件佛观音等玻璃种翡翠'
    @keywords ='世代景星珠宝 翡翠 手镯 挂件 佛 观音 玻璃种'
    @description ='世代景星珠宝城专卖时尚手镯挂件佛观音等玻璃种翡翠，并为广大翡翠友提供翡翠交流，出售平台'
  end
  def about

  end
  def aboutus
    @title = '佳春长珠宝店  云南省昆明世代景星珠宝城一楼18号'
    @keywords ='世代景星珠宝 翡翠 手镯 挂件 佛 观音 玻璃种'
    @description ='本站仅销售天然翡翠A货。如售假货，愿承担一切法律责任，承诺如玉恒久。云南省昆明世代景星珠宝城一楼18号'
  end
  def buy

    @title = '佳春长珠宝店 购物指南  云南省昆明世代景星珠宝城一楼18号'
    @keywords ='世代景星珠宝 购物指南'
    @description ='本站仅销售天然翡翠A货。如售假货，愿承担一切法律责任，承诺如玉恒久。云南省昆明世代景星珠宝城一楼18号'
  end

  
  def question
    @title = '佳春长珠宝店 购物指南  云南省昆明世代景星珠宝城一楼18号'
    @keywords ='世代景星珠宝 购物指南'
    @description ='本站仅销售天然翡翠A货。如售假货，愿承担一切法律责任，承诺如玉恒久。云南省昆明世代景星珠宝城一楼18号'
  end
end
