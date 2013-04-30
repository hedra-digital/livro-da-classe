server '198.211.112.162', :app, :web, :db, :primary => true
set :deploy_to, "/home/deploy/apps/livrodaclasse_staging"
set :branch, 'staging'
set(:rails_env) { "#{stage}" }
