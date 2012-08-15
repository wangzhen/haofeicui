#先执行 capify . 
set :stages, %w(staging production 02)
set :default_stage, "production"
set :keep_releases, 3
require 'capistrano/ext/multistage'

set :application, "jadejade.cn"
#set :repository,  "https://empirejade.googlecode.com/svn/trunk/userauth"
#set :repository,  "git@github.com:wangzhen/haofeicui.git"
set :repository,  "https://github.com/wangzhen/haofeicui.git"
set :use_sudo, false
set :runner, "root"

set :scm, :git
#set :scm, "git"
set :user, "wangzhen"  # The server's user for deploys
set :scm_passphrase, "wangzhen"  # The deploy user's password
#set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# set :user do Capistrano::CLI.ui.ask('SSH User: ') end
 set :user, 'wangzhen'
 set :password do Capistrano::CLI.password_prompt('SSH Password: ') end
#set :password, 'xxxx '
#set :scm_user do Capistrano::CLI.ui.ask('SVN User: ') end
#set :scm_user, "vwangzhen"
#set :scm_password do Capistrano::CLI.password_prompt('SVN Password: ') end

after 'deploy' , 'deploy:cleanup'
#set :scm_password, 'zn2Qq9mm7Bs4'
#
#set :scm_prefer_prompt, true
#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#run "cp /home/wangzhen/www/jadejade.cn/deploy/database.yml /home/wangzhen/www/jadejade.cn/current/config/."