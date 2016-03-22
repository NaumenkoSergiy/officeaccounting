set :output, "#{path}/log/cron.log"
every 1.day do
  job_type :backup_task, 'cd :path && :environment_variable=:environment BASE_PATH=:base_path bundle exec rake :task --silent :output'
  backup_task 'db:backup', base_path: '/home/deploy'
end
