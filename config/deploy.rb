# config valid only for Capistrano 3.1
lock '3.2.1'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

user = ENV['USER']
password = ENV['PASSWORD'] || 'activebridge'
branch = ENV['BRANCH'] || 'master'
application = 'active-books'

set :repo_url, 'git@github.com:activebridge/active-books.git'

server '104.131.21.46', user: user, password: 'activebridge', roles: [:app, :web, :db], primary: true
set :user, user

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/#{user}/apps/#{application}"
set :tmp_dir, "/home/#{user}/tmp"
set :rails_env, 'production'

set :application, application
set :repo_url, 'git@github.com:activebridge/active-books.git'
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0'
set :default_shell, '/bin/bash -l'
set :ssh_options, { :forward_agent => true }

set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, ''
set :bundle_without, %w{test development}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
# Default value for keep_releases is 5
set :keep_releases, 2

set :branch, branch
set :pty, true
set :use_sudo, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

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
