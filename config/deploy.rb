require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "Livro da Classe"

set :scm, :git
set :repository,  "git@github.com:hedra-digital/livro-da-classe.git"
set :deploy_via, 'copy'
set :user, 'deploy'

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "livrodaclasse_rsa")]

set :use_sudo, false
set :keep_releases, 3

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

after "deploy:update_code", "deploy:symlink_db"
after "deploy:restart", "deploy:cleanup"
after "deploy", "deploy:migrate"

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
