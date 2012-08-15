# coding: utf-8
namespace :db do
  desc "init the tables of provinces,cities,districts using Hpricot"
  task :email1 => :environment do
    p_file_path = File.join(RAILS_ROOT,'public','email1.txt')
    f =  File.open(p_file_path, 'r')
    f.readlines.each do |line|
      e = line.split('"')
      Sendemail.create({:email => e[-2]})
    end
  end
  task :destroy_email => :environment do
    Sendemail.find(:all ,:conditions =>["emails like '%.%.cn%'"]).destroy
  end
end