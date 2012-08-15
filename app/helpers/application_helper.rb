# coding: utf-8
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def province_all
    Province.find(:all).map{|p|[p.name,p.id]}
  end

  #default replace  #{model}_city_id  #{model}_district_id
  # select_province_city('user','province' ,{:replace_district_id=>"user_district_id" , :replace_city_id=>"user_city_id"})
  #
  def  select_province_city(model,name ,options={} ,html_options={})


    city_id = options[:city_id].blank? ? "city_id" :options[:city_id]
    district_id = options[:district_id].blank? ? "district_id" :options[:district_id]
    replace_city_id = model + "_"+city_id
    replace_district_id = model + "_"+district_id
    if model =="search"
      replace_city_id = model + "_conditions_"+city_id + "_is"
      replace_district_id = model + "_conditions_"+district_id + "_is"
    end
    options.delete('city_id')
    options.delete('district_id')
    options.delete('onchange')
    html_options[:onchange] = remote_function(
      :url =>{:controller=>'/ajax',
        :action=>"province_select",
        :model =>model,
        :city_id=>city_id,:district_id=>district_id,
        :replace_city_id=>replace_city_id,:replace_district_id=>replace_district_id}  ,
      :with=>"'province_id='+this.value")
    #搜索处理
    if model =="search"
      collection_select(model+'[conditions]' , "#{name}_is" , Province.find(:all) ,"id","name",   {:include_blank=>true} ,html_options  )
    else
      collection_select(model , name , Province.find(:all) ,"id","name",   {:include_blank=>true} ,html_options  )
    end


  end

  def alternate(name = :default)
    return cycle("", "even", :name => name)
  end


  def gender_options
    return [[t('male'), true], [t('female'), false]]
  end

  def parse_date(time)
    time.strftime("%Y/%m/%d") if time
  end

  def gender(boolean)
    if boolean == true
      t("male")
    elsif boolean == false
      t("female")
    else
      ""
    end
  end

  def table_attrs
    %Q|cellpadding="0" cellspacing="0" border="0" width= "100%" class="list"|
  end

#  # ajax 分页
#  class AjaxLinkRenderer < WillPaginate::LinkRenderer
#    def page_link_or_span(page, span_class, text = nil)
#      text ||= page.to_s
#      if page and page != current_page
#        classnames = span_class && span_class.index(' ') && span_class.split(' ', 2).last
#        @template.link_to_remote text, :url=>url_for(page),:method=>:get ,:html=>{:class => classnames}
#      else
#        page_span page, text, :class => span_class
#      end
#    end
#  end

  #选择产品parent 分类  �?��下面�?“category_children�?id 表示以便替换
  #  for example
  #   <%=  select_caegory_parent("product") %>
  #    <%=render  :partial => "/shared/category_children" , :locals=>{:categories=>@categories,:object=>"product"} %>
  def select_category_parent(object,category)
    select_tag(:parent_id , options_for_select([["",""]]+Category.roots.map{|c|[c.name,c.id]},category.try(:id)),
      {:onchange =>remote_function(:url =>{:controller=>'/ajax',:action=>"category_select",:object=>object} , :with=>"'category_id='+this.value")} )
  end






  def display_categories(categories)
    ret = "<ul class=\"treeroot categories\">"
    for category in categories
      if category.is_root?
        ret += "<li id=\"li_category_#{category.id}\">"
        ret += link_to_category category
        ret += find_all_subcategories(category)
        ret += "</li>"
      end

    end
    ret += "</ul>"
  end

  def find_all_subcategories(category)
    if category.children.size > 0
      ret = '<ul>'
      category.children.each { |subcat|
        ret += "<li id=\"li_category_#{subcat.id}\">"
        ret += link_to_category subcat
        if subcat.children.size > 0
          ret += find_all_subcategories(subcat)
        end
        ret += '</li>'
      }
      ret += '</ul>'
    else
      ""
    end
  end

 

  def page_title_tag
    title = ["Love Chic"]
    title.insert(0,@html_title) unless @html_title.blank?
    title.map(&:titleize).join(' - ')
  end

  def page_desc_tag
    desc = ["Love Chic"]
    desc.insert(0,@html_desc) unless @html_desc.blank?
    desc = desc.map(&:titleize).join(' - ')
    %Q|<meta name="description" content="#{desc}" />|
  end

  def split_keyword(keyword)
    keyword.gsub!(/[　\s\t]+$/o, "")
    keyword.gsub!(/^[　\s\t]+/o, "")
    keyword.gsub!(/[　\s\t]+/o, " ")
    keyword.split(/(\s)/)
  end

  def get_price_type(price)
    case price.product_type.name
    when "internet"
      "非会员价"
    when "user"
      "会员价"
    end
  end

  def get_price(price)
    case price.product_type.name
    when "internet"
      price.price.to_s + " 元"
    when "user"
      "<span style='color:red'>#{price.price} 元</span>"
    end
  end

  def parse_is_public(public)
    public ? "公开" : "非公开"
  end

  def new_line(text, html_options={})
    start_tag = tag('p', html_options, true)
    text = h(text).to_s.dup
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/(\n)/, '\1<br/>') # 1 newline   -> br
    text.gsub!(/ /, '&nbsp;') # space -> &nbsp;
    text.insert 0, start_tag
    text << "</p>"
  end
  
  def to_seo(string)
    CGI::escape(string.to_s.delete('.@~`;":?<>,.*&^%$#@!|\\\\}{[]\' = + - '))
  end



    #所有产品顶级分类下拉
    def category_all_parent
      Category.roots.map{|c|[c.name,c.id]}
    end

    # 订单状态下拉数据
    def order_status_all
      OrderStatus.all.map{|o|[o.name,o.id]}
    end

    # 支付方式下拉数据
    def payment_all
      Payment.all.map{|p| [p.name,p.id]}
    end

    # 发送时间下拉数据
    def delivery_schedule_date_all
      DeliverySchedule.all.map{|d|[d.name,d.id]}
    end


    # 邮送方式下拉数握
    def mailing_all
      Mailing.all.map{|m|[m.name,m.id]}
    end

#    def page_title_tag
#      @page_title || 'Admin / ' + controller_name
#    end

    def title(text, options = {})
      content_for(:title) { text }
    end

    def backward_button_tag(path= nil,text = nil, options = {})
      button_link_tag(
        text || t("button.back"),
        (url_for(path = (path ||= {:action=>"index"} )) rescue url_for(:back)),
        options.reverse_merge(:id => 'backward-button', :class => 'button')
      )
    end

    # Generate a hyper link, clicking on which will popup a modal dialog.
    def link_to_dialog(text, options, html_options = {})
      link_to(
        text,
        options.reverse_merge(:width => 650, :height => 500, "TB_iframe" => "true"),
        html_options.reverse_merge(:class => "thickbox", :title => text)
      )
    end

    def link_to_window(text, options, html_options = {})
      link_to(
        text,
        options,
        html_options.merge(:onclick => "return ReferenceWindow.open(this.href);")
      )
    end

    # Date range select using Calender Date Select
    def date_range_select_tag(name_prefix, field, options = {})
      html = []
      [:start, :end].each do |part|
        html << calendar_date_select_tag(
          "#{name_prefix}[#{field}][#{part}]",
          (options[name_prefix][field][part] rescue ''),
          :size => 10
        )
      end

      return html.join(' ~ ')
    end

    # Definition for styling the <code>textarea</code> tag.
    def text_area_options
      { :cols => 30, :rows => 3 }
    end

    # Popup a module window to pickup/browser related records. The callback
    # will be fired after closing the dialog window.
    # For more information, check out the "ReferenceWindow" object in "admin.js"
    def button_to_reference_window(url, javascript, options ={})
      link_to_function 'pickup', javascript, options
    end

    def order_status_select_tag(order)
      return select_tag(
        "order[status_id]",
        options_for_select(
         [""] + OrderStatus.all.map{|o|[o.name,o.id]}, order.status_id
        ),
        :onchange => remote_function(
          :url => admin_order_path(order),
          :method => :put,
          :submit => "order_status_#{order.id}",
          :before => "$('loader_#{order.id}').show();disabled_page('true');",
          :complete => "$('loader_#{order.id}').hide();disabled_page('false');"
        )
      )
    end

end
