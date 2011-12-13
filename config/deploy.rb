require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'thinking_sphinx/deploy/capistrano'

set :ssh_options, {:forward_agent => true }
set :use_sudo, false
set :spinner, false

set :stages, %w(dev prod)
set :default_stage, "dev"

set :scm, :git
set :application, "studyfiles"
set :repository,  "git@github.com:pronix/studyfiles.git"

set :deploy_via, :remote_cache
set :keep_releases, 3
set :bundle_flags,       "--quiet"
set :rails_env, "production"
