# OPTIMIZE: need to state - for release and quick update
role :web, "studyfiles.adenin.ru:6022"
role :app, "studyfiles.adenin.ru:6022"
role :db,  "studyfiles.adenin.ru:6022", :primary => true
role :db,  "studyfiles.adenin.ru:6022"

set :deploy_to, "/var/www/#{application}"

set :branch, "ezo"
set :user, "rvm_user"

set :thinking_sphinx_configure_args, "./configure --with-pgsql=/usr/include/pgsql --prefix=#{shared_path}/sphinx"

set :rvm_type, :user
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2-head'

after "deploy:finalize_update", "deploy:db:symlink"
after "deploy:finalize_update", "deploy:create_log"

after 'deploy:update_code', 'deploy:clear_public_system'
after 'deploy:update_code', 'deploy:stop_sphinx'
after 'deploy:update_code', 'delayed_job:stop'
after 'deploy:update_code', 'unicorn:graceful_stop'


before 'deploy:migrate', 'deploy:prepare_db'
after 'deploy:update',  'deploy:migrate'
after 'deploy:migrate', 'delayed_job:restart'

after 'deploy:migrate', 'deploy:load_seed'
after 'deploy:load_seed', 'deploy:load_sample'

after 'deploy:migrate', 'deploy:activate_sphinx'
after 'deploy:migrate', 'deploy:precompile_assets'

after 'deploy:migrate', 'misc:university_rating'

namespace :delayed_job do
  task :restart do
        run "cd #{latest_release}; RAILS_ENV=#{rails_env} script/delayed_job restart"
  end
  task :stop do
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end
end

namespace :misc do
  task :university_rating do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake university:rating"
  end
end


namespace :deploy do
  task :clear_public_system do
    run "cd #{latest_release} && rm -rf public/system/*"
  end

  task :load_seed do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  end

  task :load_sample do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:load_sample"
  end

  task :precompile_assets do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end

  task :prepare_db do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:drop db:create"
  end

  task :create_log do
    run "rm -rf #{latest_release}/log"
    run "mkdir #{latest_release}/log"
  end

  namespace :db do
    task :symlink do
      run "ln -nfs #{shared_path}/database.yml #{latest_release}/config/database.yml"
    end
  end

  task :stop_sphinx do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake thinking_sphinx:stop"
  end

  task :activate_sphinx do
    if ENV['NEW']
      run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake thinking_sphinx:configure"
    else
      run "ln -nfs #{shared_path}/production.sphinx.conf #{latest_release}/config/production.sphinx.conf"
    end
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake thinking_sphinx:index"
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake thinking_sphinx:start"
  end
end

require 'capistrano-unicorn'
