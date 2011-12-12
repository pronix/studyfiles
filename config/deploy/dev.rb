role :web, "harryposter.adenin.ru:6022"
role :app, "harryposter.adenin.ru:6022"
role :db,  "harryposter.adenin.ru:6022", :primary => true
role :db,  "harryposter.adenin.ru:6022"

set :deploy_to, "/var/www/#{application}"

set :branch, "master"
set :user, "root"
