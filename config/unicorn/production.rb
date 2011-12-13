# Set unicorn options
worker_processes 1
preload_app true
timeout 180
listen "tmp/unicorn.sock", :backlog => 64
# listen '0.0.0.0:9000'


# Log everything to one file
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"


before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
