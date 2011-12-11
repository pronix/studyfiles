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
  require 'cucumber/thinking_sphinx/external_world'
  require 'email_spec'
  require 'email_spec/cucumber'
  require 'database_cleaner'
  require 'database_cleaner/cucumber'

  
  DatabaseCleaner.strategy = :truncation

  Capybara.default_selector = :css
  Cucumber::Rails::World.use_transactional_fixtures = true
  Cucumber::ThinkingSphinx::ExternalWorld.new
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers

  ActionController::TestCase.class_eval do
    def self.fixture_path
      File.join(Rails.root, 'test/fixtures/')
    end
  end

  #FIXME приходится перед тестами делать rake thinking_sphinx:stop, и после тестов обратно запускать
  # можно автоматизировать остановку\запуск сфинкса внутри env.rb, но возможно есть более красивое решение
  ts = ThinkingSphinx::Configuration.instance
  ts.build
  FileUtils.mkdir_p ts.searchd_file_path
  ts.controller.index
  ts.controller.start
  at_exit do
    ts.controller.stop
  end
  ThinkingSphinx.deltas_enabled = true
  ThinkingSphinx.updates_enabled = true
  ThinkingSphinx.suppress_delta_output = true
  
  Before do
    ActiveRecord::Fixtures.reset_cache
    fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
    fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
    ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
    ts.controller.index
  end
  
  ActionController::Base.allow_rescue = false
end

Spork.each_run do
  # When all routes are rigth and fixtures too => comment this
  FactoryGirl.factories.clear
  Dir[Rails.root.join('spec/factories/**/*.rb')].each{|f| load f}
  Studyfiles::Application.reload_routes!
  Cucumber::Rails::Database.javascript_strategy = :truncation
end
