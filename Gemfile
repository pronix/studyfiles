# -*- coding: utf-8 -*-
source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'pg'
gem 'warden'
gem 'devise'

gem 'paperclip'
gem 'jquery-rails'
gem 'delayed_job'
gem 'hierarchy', :path => 'vendor/plugins/hierarchy'
gem 'rubyzip'
gem 'ffi', '1.0.11'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'thinking-sphinx', '2.0.10'

gem 'rails-settings-cached', :require => 'rails-settings'
gem 'nested_form', :git => 'git://github.com/ryanb/nested_form.git'


group :test,:development do
  # For help
  gem 'seed-fu', '~> 2.1.0'
  gem 'unicorn'
  #использользуем для подсветки синтаксиса в исходных кодах
  gem 'coderay'
  gem 'builder'
  gem 'silent-postgres'

  # For test
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'email_spec'
  gem 'cucumber-rails'
  gem 'database_cleaner'

  # Spork
  gem 'spork', :git => 'git://github.com/sporkrb/spork.git'
  gem 'guard-spork', :git => 'git://github.com/guard/guard-spork.git'
  gem 'guard-cucumber', :git => 'git://github.com/guard/guard-cucumber.git'

  # Not important
  gem 'rails-erd', :require => false
end
