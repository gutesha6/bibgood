Rails.application.configure do
  config.web_console.whitelisted_ips = '192.168.0.0/16'
  config.generators do |g|
    g.template_engine :erb
    g.test_framework :rspec
    g.assets false
    g.helper false
    g.jbuilder false
    g.stylesheets false
    g.view_specs false
  end
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'], port: ENV['SMTP_PORT']
  }
  config.action_mailer.preview_path = 'spec/mailers/previews'
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.quiet = true
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
