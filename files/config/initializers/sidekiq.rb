# frozen_string_literal: true

Rails.application.configure do
  # Use application-specific job queues. Makes it easier to use sidekiq in local
  # development. Add the app name prefix in config/sidekiq.yml.
  # :queues:
  #   - appname_mailers
  #   - appname_default
  #   - ...
  # config.active_job.queue_name_prefix = Rails.application.class.module_parent_name.parameterize

  # Use sidekiq in production and for local development.
  case Rails.env
  when 'production', 'development'
    config.active_job.queue_adapter = :sidekiq
  end
end
