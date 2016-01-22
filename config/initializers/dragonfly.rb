require "dragonfly"

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret Settings.secret_key_base

  url_format "/media/:job/:name"

  url_host Settings.url

  if Settings.s3
    datastore :s3, Settings.s3.to_hash
  else
    datastore :file,
      :root_path   => Rails.root.join("public/system/dragonfly", Rails.env),
      :server_root => Rails.root.join("public")
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
