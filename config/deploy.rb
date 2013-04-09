require 'bundler/capistrano'


set :application, "circular"
set :repository,  "git@gitlab.adyton.net:rico.simke/circular.git"

ssh_options[:forward_agent] = true

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "10.3.100.204"                          # Your HTTP server, Apache/etc
role :app, "10.3.100.204"     
role :db,  "10.3.100.204", :primary => true # This is where Rails migrations will run

set :user, 'root'
set :user_sudo, false

# set :bundle_gemfile,  "src/Gemfile"
set :deploy_to, "/usr/local/www/#{application}"
set :deploy_via, :remote_cache

# http://stackoverflow.com/questions/9468912/missing-folder-errors-during-capistrano-deploy
set :normalize_asset_timestamps, false

set :keep_releases, 3


# if you want to clean up old releases on each deploy uncomment this:
after "deploy:cold", "deploy:restart"
ater "deploy", "deploy:restart"
after "deploy:restart", "deploy:seed"
after "deploy:seed", "deploy:cleanup"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :migration do
    p 'create'
    run "cd #{current_path}; bundle exec rake db:migrate RAILS_ENV=production"
	end

  task :seed do
   	p 'seed'
   	run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=production"
   end


	task :assets_precompile do
    run "cd #{current_path}; bundle exec rake assets:precompile"
	end

end

# http://goo.gl/r2qZn
load 'deploy/assets'