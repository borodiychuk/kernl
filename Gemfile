source "https://rubygems.org"

gem "rails", "4.2.5"
gem "pg", "~> 0.15"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "config"
gem "countries", :require => "countries/global"
gem "dragonfly"
gem "dragonfly-s3_data_store"
gem "rollbar"
gem "puma"
gem "devise_token_auth"
gem "sidekiq"

# See https://github.com/rails/execjs#readme for more supported runtimes
gem "therubyracer", platforms: :ruby

gem "jquery-rails"
gem "slim"

gem "rails-assets-angular",                 :source => "https://rails-assets.org"
gem "rails-assets-angular-resource",        :source => "https://rails-assets.org"
gem "rails-assets-angular-cookie",          :source => "https://rails-assets.org"
gem "rails-assets-angular-cookies",         :source => "https://rails-assets.org"
gem "rails-assets-angular-animate",         :source => "https://rails-assets.org"
gem "rails-assets-angular-loading-bar",     :source => "https://rails-assets.org"
gem "rails-assets-angular-sanitize",        :source => "https://rails-assets.org"
gem "rails-assets-underscore",              :source => "https://rails-assets.org"
gem "rails-assets-angular-i18n",            :source => "https://rails-assets.org"
gem "rails-assets-ui-router",               :source => "https://rails-assets.org"
gem "rails-assets-datetimepicker",          :source => "https://rails-assets.org"
gem "rails-assets-ng-wig",                  :source => "https://rails-assets.org"
gem "rails-assets-angular-google-maps",     :source => "https://rails-assets.org"
gem "rails-assets-ng-file-upload-shim",     :source => "https://rails-assets.org"
gem "rails-assets-angular-ui--ui-sortable", :source => "https://rails-assets.org"
gem "rails-assets-angular-translate",       :source => "https://rails-assets.org"
gem "rails-assets-ng-file-upload",          :source => "https://rails-assets.org"
gem "rails-assets-ng-token-auth",           :source => "https://rails-assets.org"

gem "bcrypt", "~> 3.1.7"

group :development, :test do
  gem "byebug"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
end


group :development do
  gem "capistrano",         :require => false
  gem "capistrano-rvm",     :require => false
  gem "capistrano-rails",   :require => false
  gem "capistrano-bundler", :require => false
  gem "capistrano3-puma",   :require => false
  gem "capistrano-sidekiq", :require => false
  gem "capistrano-git-submodule-strategy", "~> 0.1", :github => "ekho/capistrano-git-submodule-strategy"
end
