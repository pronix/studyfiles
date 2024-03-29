# -*- coding: utf-8 -*-
source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'pg'
gem 'warden'
gem 'devise'
gem 'russian'
gem 'will_paginate'
gem 'paperclip'
gem 'jquery-rails'
gem 'delayed_job'
gem 'rubyzip'
gem 'ffi', '1.0.11'
gem 'thinking-sphinx', '2.0.10'
gem 'cancan'
gem 'haml'

gem 'unicorn'
gem 'meta_search'
gem 'whenever'

gem 'inboxes', :path => 'vendor/inboxes'
gem 'hierarchy', :path => 'vendor/plugins/hierarchy'
gem 'recaptcha', :require => 'recaptcha/rails'

gem 'rails-settings-cached', :require => 'rails-settings'
gem 'nested_form', :git => 'git://github.com/ryanb/nested_form.git'


gem 'capistrano'
gem 'capistrano-ext'
gem 'coderay'
gem 'capistrano-unicorn'
gem 'prototype-rails', :git => 'git://github.com/rails/prototype-rails.git' #для ajax-загрузки превью изображений

# For sample migrations on dev server
gem 'faker'

gem 'exception_notification'

group :test,:development do
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
  gem 'guard-rspec', :git => 'git://github.com/guard/guard-rspec.git'

  # Not important
  # gem 'rails-erd', :require => false
  gem 'ruby-debug19', :require => false
  gem 'launchy', :require => false
end
