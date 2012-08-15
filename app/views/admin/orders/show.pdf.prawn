pdf.font Rails.root.join("public", "ArialUni.ttf")

pdf.text @title || "Love Chic", :size => 30, :align => :center, :vposition => :top
pdf.image "public/images/love_chic_pdf.jpg",:position => :right, :vposition => :top,:width=>353,:height=>366, :scale => 0.2
pdf.text l(Time.now, :format => :long), :align => :right

# Delivery information
pdf.move_down 10
delivery_info = [:postal_code, :full_city_name, :user_name, :tel, :mobile].map do |field|
  [Order.human_attribute_name(field.to_s) + ":", @order.send(field)]
end
pdf.table delivery_info, :border_color => "FFFFFF", :vertical_padding => 2, :align => :left

# Order header information
pdf.move_down(20)
pdf.text t(".order_header"), :size => 15, :align => :center

headers = [[
  @order.serial,
  @order.user_name,
  parse_date(@order.created_at),
  parse_date(@order.delivery_schedule_date),
  (@order.delivery_schedule.name if @order.delivery_schedule)
]]

pdf.table headers, :border_style => :grid, :width => 540, :align => :center,
  :headers => ["serial", "user_name", "created_at", "delivery_schedule_date", "delivery_schedule_id"].map { |field| Order.human_attribute_name(field) }

# Order details
pdf.move_down(20)
pdf.text t(".order_details"), :size => 15, :align => :center

lines = @order.order_lines.map do |line|
  [
    line.name,
    number_to_currency(line.price),
    line.quantity,
    number_to_currency(line.subtotal),
  ]
end

# Shipping charge
unless @order.shipping_charge.zero?
  lines << ["Shipping Charge", "", "", number_to_currency(@order.shipping_charge)]
end

pdf.table lines, :border_style => :grid, :width => 540,
  :headers => ["name", "price", "quantity", "subtotal"].map { |field| OrderLine.human_attribute_name(field) },
  :align => { 0 => :left, 1 => :right, 2 => :right, 3 => :right }

pdf.move_down 10
pdf.with_options(:align => :right) do |p|
  unless @order.shipping_charge.zero?
    p.text "#{t("subtotal")}: #{number_to_currency(@order.subtotal+@order.shipping_charge)}"
  else
    p.text "#{t("subtotal")}: #{number_to_currency(@order.subtotal)}"
  end
  p.text "#{t("discount")}: #{number_to_currency(@order.adjustment)}"
  p.text "#{t("total")}: #{number_to_currency(@order.total)}"
end

# Contact
pdf.move_down 20
contacts = [
  [" 公司名:", "上海佳若喜貿易有限公司\nShanghai Love Chic Co.,Ltd."],
  [" 地址:", "上海市長寧区武夷路351号208室\nRoom105,351 Wuyi Road,Changning,Shanghai"],
  [" 电话:", "021-5155-3335,3336"],
  [" 传真:", "021-5155-3337"],
  [" 支持:", "cerahs@cerahs.com.cn"],
  [" 网址:", "http://love_chic.com"]
]
pdf.table contacts, :border_color => "FFFFFF", :vertical_padding => 2