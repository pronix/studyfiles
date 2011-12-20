set :output, "#{path}/log/cron_log.log"

every '*/10 * * * *' do
  rake "university:rating"
end
