# NOTE: Basically we spawn workers instead of threads for concurrency, we do it
# this way because the way that we connect to an organization database per
# request may contaminate other parallel requests.

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 1 }
threads threads_count, threads_count
port        ENV.fetch('PORT') { 3000 }
environment ENV.fetch('RAILS_ENV') { 'development' }
workers ENV.fetch('WEB_CONCURRENCY') { 3 }
preload_app!
before_fork do
  ApplicationRecord.connection_pool.disconnect! if defined?(ActiveRecord)
end
on_worker_boot do
  ApplicationRecord.establish_connection if defined?(ActiveRecord)
end
plugin :tmp_restart
