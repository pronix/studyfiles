set :output, "#{path}/log/cron_log.log"

every 1.hours do
  rake "university:rating"
end
