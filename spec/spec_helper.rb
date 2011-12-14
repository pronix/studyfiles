require 'rubygems'
require 'spork'

if Spork.using_spork?
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'factories'
  require 'ruby-debug'

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
  end

  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

Spork.each_run do
  FactoryGirl.factories.clear
  Dir[Rails.root.join('spec/factories/**/*.rb')].each{|f| load f}

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end
