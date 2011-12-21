set :output, "#{path}/log/cron_log.log"

every '*/10 * * * *' do
  rake "rating:update_all"
end

every 1.hour do
  rake "thinking_sphinx:index"
end
