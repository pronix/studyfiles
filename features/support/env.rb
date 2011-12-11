# -*- coding: utf-8 -*-
require 'rubygems'
require 'spork'

if Spork.using_spork?
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

Spork.prefork do
  require 'cucumber/rails'
  require 'cucumber'
  require 'cucumber/rails/world'
  require 'factory_girl/step_definitions'
  require 'email_spec'
  require 'email_spec/cucumber'
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  require 'ruby-debug'

  require 'cucumber/thinking_sphinx/external_world'
  Cucumber::Rails::World.use_transactional_fixtures = true
  DatabaseCleaner.strategy = :truncation
  
  Capybara.default_selector = :css

  ActionController::TestCase.class_eval do
    def self.fixture_path
      File.join(Rails.root, 'test/fixtures/')
    end
  end

  Before do
    ActiveRecord::Fixtures.reset_cache
    fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
    fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
    ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
  end

  ActionController::Base.allow_rescue = false
end

Spork.each_run do
  Before do
    Cucumber::ThinkingSphinx::ExternalWorld.new
  end
  # When all routes are rigth and fixtures too => comment this
  FactoryGirl.factories.clear
  Dir[Rails.root.join('spec/factories/**/*.rb')].each{|f| load f}
  Studyfiles::Application.reload_routes!
  Cucumber::Rails::Database.javascript_strategy = :truncation
end
