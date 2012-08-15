pdf.font Rails.root.join("public", "ArialUni.ttf")
pdf.text @title || "Love Chic", :size => 30, :align => :center, :vposition => :top
pdf.image "public/images/love_chic_pdf.jpg",:position => :right, :vposition => :top,:width=>353,:height=>366, :scale => 0.2

pdf.text "#{t(".search_condition")}"

search_headers_1 = ["订单号", "顾客姓名", "省" ,"城市", "地区"]
search_data_1 =
  [[
    "#{@search_order.serial}",
    "#{@search_order.try(:user).try(:name)}",
    "#{@search_order.try(:province).try(:name)}",
    "#{@search_order.try(:city).try(:name)}",
    "#{@search_order.try(:district).try(:name)}"
  ]]

search_headers_2 = ["订单日期", "预定发送日", "订单状态"]
orderd_on_from = ""
orderd_on_to = ""
 unless params[:search].blank? or params[:search][:conditions].blank?
    unless search[:conditions][:ordered_on_gt].blank?
      orderd_on_from = search[:conditions][:ordered_on_gt]
    end
 end

unless params[:search].blank? or params[:search][:conditions].blank?
    unless search[:conditions][:ordered_on_lt].blank?
      orderd_on_to = search[:conditions][:ordered_on_lt]
    end
 end

delivery_from = ""
delivery_to = ""
 unless params[:search].blank? or params[:search][:conditions].blank?
    unless search[:conditions][:delivery_schedule_date_gt].blank?
      delivery_from = search[:conditions][:delivery_schedule_date_gt]
    end
 end

 unless params[:search].blank? or params[:search][:conditions].blank?
    unless search[:conditions][:delivery_schedule_date_lt].blank?
      delivery_to = search[:conditions][:delivery_schedule_date_lt]
    end
 end




search_data_2 =
  [[
    "#{orderd_on_from}～#{orderd_on_to}",
    "#{delivery_from}～#{delivery_to}",
    "#{@search_order.try(:status).try(:name)}",
  ]]

headers = ["订单号/受注日", "类别/客户姓名", "住所/电话", "金额", "发送日/发送时间", "完成日/状态"]

data = @orders.map do |order|
    chars = order.address.chars.to_a
  [
    "#{order.serial}\n#{parse_date(order.created_at)}",
    "#{order.try(:user).try(:customer_type).try(:name)}\n#{order.user_name}",
    "#{chars[0..14]}\n#{chars[15..28].to_s+"\n" unless chars[15..28].nil?}#{chars[29..42].to_s+"\n" unless chars[29..42].nil?}#{chars[43..56].to_s+"\n" unless chars[43..56]}#{chars[57..60].to_s+"\n" unless chars[57..60].nil?}#{order.tel}",
    "#{number_to_currency(order.total, :precision => 0)}",
    "#{order.delivery_schedule_date}\n#{order.delivery_schedule.try(:name)}",
    "#{order.completed_on}\n#{order.status.try(:name)}"
  ]
end

pdf.table search_data_1, :headers => search_headers_1,
  :align => { 0 => :center, 1 => :center, 2 => :center, 3 => :center },
  :row_colors => ["DDDDDD", "FFFFFF"], :width => 540
pdf.table search_data_2, :headers => search_headers_2,
  :align => { 0 => :center, 1 => :center, 2 => :center},
  :row_colors => ["DDDDDD", "FFFFFF"], :width => 540

pdf.move_down(30)

pdf.text "#{t(".orders_count")} : #{@orders.length}　　　#{t(".total")}: ¥ #{"%.2f" % @orders.sum(&:total).to_s}", :align => :left
pdf.table data, :headers => headers,
  :align => { 0 => :center, 1 => :center, 2 => :center, 3 => :center, 4 => :center, 5 => :center },
  :row_colors => ["DDDDDD", "FFFFFF"],:width=>540

pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 20] do
  pdf.text "共有 #{pdf.page_count} 页", :size => 12,:align => :center
end


