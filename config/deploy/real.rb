server '198.211.112.162', :app, :web, :db, :primary => true
set :deploy_to, "/home/deploy/apps/real_staging"
set :branch, 'real'
set(:rails_env) { "#{stage}" }
