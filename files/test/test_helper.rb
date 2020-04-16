# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require_relative '../config/environment'
require 'rails/test_help'

require 'webmock/minitest'
require 'mocha/minitest'

Webdrivers.cache_time = 1.month.to_i # Only check for new drivers periodically
WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: 'chromedriver.storage.googleapis.com'
)

class ActiveSupport::TestCase
  # parallelize(workers: :number_of_processors)
  fixtures :all
end
