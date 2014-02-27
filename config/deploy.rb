require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'sidekiq/capistrano'

set :stages, ["staging", "sales", "sletras", "production", "tipostaging"]
set :default_stage, "staging"

set :application, "Livro da Classe"

set :scm, :git
set :repository,  "git@github.com:hedra-digital/livro-da-classe.git"
set :deploy_via, 'copy'
set :user, 'deploy'

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "livrodaclasse_rsa"), File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :use_sudo, false
set :keep_releases, 3

after "deploy:finalize_update", "deploy:symlink_config", "deploy:symlink_assets"
after "deploy:restart", "deploy:cleanup"
after "deploy", "deploy:migrate"

namespace :deploy do
  desc "Symlinks config files"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/config.yml #{release_path}/config/config.yml"
  end

  desc "Symlinks assets"
  task :symlink_assets, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/ckeditor_assets #{release_path}/public/"
    run "ln -nfs #{deploy_to}/shared/covers #{release_path}/public/"
    run "ln -nfs #{deploy_to}/shared/books #{release_path}/public/"
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
