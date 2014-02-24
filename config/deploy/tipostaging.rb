server '198.211.112.162', :app, :web, :db, :primary => true
set :deploy_to, "/home/deploy/apps/tipografia_staging"
set :branch, 'tipografia_staging'
set(:rails_env) { "#{stage}" }