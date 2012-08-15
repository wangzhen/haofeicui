# coding: utf-8
require 'hpricot'

namespace :db do
  desc "init the tables of provinces,cities,districts using Hpricot"
  task :init_city => :environment do
    puts "import National cities..."
    p_file_path = File.join(RAILS_ROOT,'public','Provinces.xml')
    c_file_path = File.join(RAILS_ROOT,'public','Cities.xml')
    d_file_path = File.join(RAILS_ROOT,'public','Districts.xml')
    unless File.exist?(p_file_path) or File.exist?(c_file_path) or File.exist?(
      d_file_path)
    puts "File not found "
    return
    end

    Province.destroy_all
    City.destroy_all
    District.destroy_all
    provinces = Hpricot.parse(File.read(p_file_path))
    cities = Hpricot.parse(File.read(c_file_path))
    districts = Hpricot.parse(File.read(d_file_path))
    (provinces/:provinces).each do |province|
      (province/:province).each do |prov|
      p_name = prov.inner_html
      puts "Initialize the data of #{p_name} "
      p_id = prov.get_attribute("id")
    
      current_province = Province.create!(:name => p_name,:id=>p_id)
      (cities/:cities).each do |cities_city|
        (cities_city/:city).each do |city|
        city_pid = city.get_attribute("pid")
        c_id = city.get_attribute("id")

        if p_id == city_pid
          c_name = city.inner_html
          current_city = City.new(:name => c_name,:id => c_id)
          current_province.cities << current_city
          (districts/:districts).each do |districts_district|
            (districts_district/:district).each do |district|
            d_name = district.inner_html
            d_id = district.get_attribute("id")
            district_cid = district.get_attribute("cid")
            if district_cid == c_id
        p " province_id-#{p_id}----city_pid-#{city_pid}----district_cid-#{district_cid}"
              d_name = district.inner_html
              current_district = District.new(:name => d_name)
              current_city.districts << current_district
            end
          end
          end
        end
      end
      end
    end
    end
    puts "this task have been done!"
  end
end