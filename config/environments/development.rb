Livrodaclasse::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.serve_static_assets = false

  config.serve_static_assets = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { :host => "localhost:3000", :sender_address => "vizir@hedra.com.br", :email_prefix => "[DEV - LIVRO DA CLASSE] ERRO NO SISTEMA "}

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  #Permit multiple threads
  #config.threadsafe!

  # Email gem configuration for help debug [VIZIR]
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "587",
    :authentication => :plain,
    :user_name => "vizir@hedra.com.br",
    :password => "h3dr4m41l"
  }

  config.middleware.use ExceptionNotifier,
  sender_address: 'vizir@hedra.com.br',
  exception_recipients: 'fellipe@vizir.com.br',
  email_prefix: "[DEV - LIVRO DA CLASSE] ERRO NO SISTEMA - ",
  sections: %w(impersonate)
end
