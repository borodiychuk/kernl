# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url,      "git@github.com:borodiychuk/kernl.git"
set :application,   "kernl"
set :user,          "dre"
set :deploy_to,     "/srv/#{fetch(:application)}"
set :format,        :pretty
set :log_level,     :debug
set :pty,           false     # Must be false for sidekiq!
set :keep_releases, 5
set :use_sudo,      false
set :deploy_via,    :remote_cache
set :ssh_options,   { :forward_agent => true }

set :linked_files, fetch(:linked_files, []).push("config/settings.local.yml")
set :linked_dirs,  fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")

# Default value for default_env is {}
# set :default_env, { :path => "/opt/ruby/bin:$PATH" }

# SCM Settings
set :scm,    :git
set :branch, "develop"
set :git_strategy, Capistrano::Git::SubmoduleStrategy

# RVM settings
set :rvm_ruby_version, "2.2"

# Puma settings
set :puma_threads,            [4, 16]
set :puma_workers,            0
set :puma_bind,               "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,              "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,                "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log,         "#{release_path}/log/puma.error.log"
set :puma_error_log,          "#{release_path}/log/puma.access.log"
set :puma_preload_app,        true
set :puma_worker_timeout,     nil
set :puma_init_active_record, false


namespace :puma do
  desc "Create Directories for Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      ## Restore that when release smth to Master
      # unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #   puts "WARNING: HEAD is not the same as origin/master"
      #   puts "Run `git push` to sync changes."
      #   exit
      # end
    end
  end

  desc "Initial Deploy"
  task :initial do
    on roles(:app) do
      before "deploy:restart", "puma:start"
      invoke "deploy"
    end
  end

  desc "Restart application"
  task :restart do
    on roles(:app), :in => :sequence, :wait => 5 do
      invoke "puma:restart"
    end
  end

  before :starting,  :check_revision
  after  :finishing, :compile_assets
  after  :finishing, :cleanup
  after  :finishing, :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
