# coding: utf-8
namespace :db do
  desc "Init reference tables by fixtures"
  task :init => :environment do
    require 'active_record/fixtures'

    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["annotate_models"].invoke
#    Rake::Task["db:init_city"].invoke
    Dir['db/fixtures/*.{rb,yml}'].each do |file|
      Fixtures.create_fixtures('db/fixtures',File.basename(file,'.*'))
    end
     p_file_path = File.join(RAILS_ROOT,'public','images','picture_test')
    admin =  Administrator.create({:name =>'admin' ,
        :password => 'admin' ,
        :password_confirmation => "admin"    })
     %w( 新闻 论坛 博客 问答 草稿 ).each do |category|
       Category.create(:name => category)
     end
    1.upto(100) do |i|
      product = Product.create({:name => "name#{i}" , 
          :serial => "serial#{i}" ,
          :proved_serial =>"proved_serial#{i}",
          :sort_id =>1,
          :color_id=>1 ,
          :price =>10 ,
          :current_price => 10,
          :introduction =>"introduction#{i}",
          :state =>1
          
        })   
      product.product_images <<  ProductImage.create(:sort=>0 ,:image=>File.new((p_file_path+"/#{i}.jpg"), 'rb'))
      
    end

    
  end
end