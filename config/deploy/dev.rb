role :web, "studyfiles.adenin.ru:6022"
role :app, "studyfiles.adenin.ru:6022"
role :db,  "studyfiles.adenin.ru:6022", :primary => true
role :db,  "studyfiles.adenin.ru:6022"

set :deploy_to, "/var/www/#{application}"

set :branch, "ezo"
set :user, "rvm_user"

set :rvm_type, :user 
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2-head'        # Or whatever env you want it to run in.

after "deploy:finalize_update", "deploy:db:symlink"
after "deploy:finalize_update", "deploy:create_log"
after  'deploy:update',  'deploy:migrate'


before 'deploy:update_code', 'thinking_sphinx:stop'
after 'deploy:update_code', 'deploy:activate_sphinx'

namespace :deploy do
  task :create_log do
    run "rm -rf #{latest_release}/log"
    run "mkdir #{latest_release}/log"
  end
  
  namespace :db do
    task :symlink do
      run "ln -nfs #{shared_path}/database.yml #{latest_release}/config/database.yml"
    end
  end

  task :activate_sphinx do
    thinking_sphinx.configure
    thinking_sphinx.index
    thinking_sphinx.start
  end
  
end
