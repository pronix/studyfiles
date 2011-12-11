require 'active_record/fixtures'

namespace :db do
  task :load_default => :environment do
    fixtures_dir = File.expand_path('db/default', Rails.root)
    fixtures = Dir[File.join(fixtures_dir, '*.yml')].map {|f| File.basename(f, '.yml') }
    ActiveRecord::Fixtures.create_fixtures(fixtures_dir, fixtures)
    Dir[File.join(fixtures_dir, '*.rb')].map {|f| load f }
  end
end
