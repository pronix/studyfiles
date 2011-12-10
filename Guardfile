guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' },
               :rspec_env => { 'RAILS_ENV' => 'test' },
               :bundler => true, :test_unit => false do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch(%r{features/support/}) { :cucumber }
end

guard 'cucumber', :cli => '--profile current -c',
                  :bundler => true,
                  :notification => false,
                  :all_on_start => false,
                  :all_after_pass => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

