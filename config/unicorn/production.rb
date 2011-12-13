# Set unicorn options
worker_processes 1
preload_app true
timeout 180
listen "127.0.0.1:9000"

# Log everything to one file
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"
