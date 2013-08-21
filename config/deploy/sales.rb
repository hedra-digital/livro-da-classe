server '198.199.73.7', :app, :web, :db, :primary => true
set :deploy_to, "/home/deploy/apps/livrodaclasse"
set :branch, 'master'
set(:rails_env) { "#{stage}" }
