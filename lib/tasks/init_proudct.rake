# coding: utf-8
require 'active_record/fixtures'
namespace :db do
  desc "init bars and icons be fixtures"
  task :init_product => :environment do
    require 'faster_csv'
    require "iconv"
    #    cnv =  Iconv.new("UTF-8//IGNORE","GBK//IGNORE")
    product = File.new("#{RAILS_ROOT}/doc/old_data.csv" , 'rb')

    product.read.each_with_index do |line ,  index|
      p index
      row = line.split(',')
      product = Product.new
      product.proved_serial = row[0].to_s
      product.serial = row[0].to_s
      product.name =  row[1].to_s
      product.price =   row[2].to_s
      product.current_price =   row[2].to_s
      product.sort_id =  row[3].to_s
      product.color_id =  row[4].to_s
      product.introduction  =  row[7].to_s
      product.rank  =  0
      if row[9] =='已出售'
      product.state  =  2
      else
      product.state  =  1
      end
      unless product.save
        p "#{row[0]}------------#{product.errors.full_messages}"
      end

    end

#    FasterCSV.parse(product , :headers => true) do |row|
#      product = Product.new
#      product.proved_serial = row[0].to_s
#      product.serial = row[0].to_s
#      product.name =  row[1].to_s
#      product.price =   row[2].to_s
#      product.current_price =   row[2].to_s
#      product.sort_id =  row[3].to_s
#      product.color_id =  row[4].to_s
#      product.introduction  =  row[7].to_s
#      product.rank  =  0
#      if row[9] =='已出售'
#      product.state  =  2
#      else
#      product.state  =  1
#      end
#
#
##            product.image1 2 =  row[5]  row[6]
##      "id";"name";"price";"sort_id";"color_id";"image1";"image2";"description";"state";"issale";"user_id";"looked";"created_at";"updated_at"
#      unless product.save
#        p "#{row[0]}------------#{product.errors.full_messages}"
#      end
#    end


  end
  task :init_product_picture => :environment do
    require 'faster_csv'
    require "iconv"
    #    cnv =  Iconv.new("UTF-8//IGNORE","GBK//IGNORE")
    product = File.new("#{RAILS_ROOT}/doc/old_data.csv" , 'rb')
 product.read.each_with_index do |line ,  index|
      p index
      row = line.split(',')
      pro =  Product.find_proved_serial(row[0])
      pro.product_images << File.new( "/root/www/haofeicui.com/shared/image/#{row[5]}")
      pro.product_images << File.new( "/root/www/haofeicui.com/shared/image/#{row[6]}")
      pro.save

    end
#    FasterCSV.parse(product , :headers => true) do |row|
#      pro =  Product.find_proved_serial(row[0])
#      pro.product_images << File.new( "/root/www/haofeicui.com/shared/image/#{row[5]}")
#      pro.product_images << File.new( "/root/www/haofeicui.com/shared/image/#{row[6]}")
#      pro.save
##    Shop.all.each do |user|
##      if  File.exist?( "#{RAILS_ROOT}/public/images/init_logo/#{user.id}.jpg")
##        user.logo = File.new( "#{RAILS_ROOT}/public/images/init_logo/#{user.id}.jpg")
##        user.save
##      end
##    end
#    end


  end
end