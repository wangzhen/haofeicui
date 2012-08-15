#http://02.jadejade.cn/
set :deploy_to, "/home/wangzhen/www/haofeicui.com"
role :app, "66.175.218.208"
role :web, "66.175.218.208"
role :db,  "66.175.218.208", :primary => true
default_run_options[:pty] = true


namespace :deploy do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, :roles => :app do
    run "cp /home/wangzhen/www/haofeicui.com/deploy/database.yml /home/wangzhen/www/haofeicui.com/current/config/."
    run "touch  #{File.join(deploy_to, current_dir)}/tmp/restart.txt"
  end
end

#namespace :deploy do
#  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
#  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
#end

