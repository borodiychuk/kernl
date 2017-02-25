Sidekiq.configure_server do |config|
   # See https://github.com/mperham/sidekiq/wiki/Best-Practices
  config.error_handlers << Proc.new { |exception, ctx_hash| Rollbar.report_exception exception, ctx_hash }
  config.redis = { url: Settings.redis }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Settings.redis }
end
