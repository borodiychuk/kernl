# See https://coderwall.com/p/ttrhow/deploying-rails-app-using-nginx-puma-and-capistrano-3

require "capistrano/setup"
require "capistrano/deploy"

require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano/rails"
require "capistrano/puma"
require "capistrano/git-submodule-strategy"

require 'capistrano/sidekiq'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
