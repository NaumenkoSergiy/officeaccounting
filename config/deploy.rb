# config valid only for Capistrano 3.1
lock '3.2.1'

user = ENV['USER']
branch = ENV['BRANCH'] || 'master'

application = 'active-books'

server '178.62.87.227', user: user, password: 'deploy', roles: [:app, :web, :db], primary: true
set :user, user

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/#{user}/apps/#{application}"
set :tmp_dir, "/home/#{user}/tmp"
set :rails_env, 'production'

set :application, application
set :repo_url, 'git@github.com:activebridge/active-books.git'
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :rvm_type, :user
set :rvm_ruby_version, '2.1.5'
set :default_shell, '/bin/bash -l'

# Default value for keep_releases is 5
set :keep_releases, 2

set :branch, branch
set :pty, true
set :use_sudo, false

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml config/application.yml}

# Default value for :scm is :git
set :scm, :git

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
      end
    end
  end

  before "deploy", "deploy:check_revision"
end