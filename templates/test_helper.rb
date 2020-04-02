run 'rm test/test_helper.rb'

file 'test/test_helper.rb', <<~CODE.strip_heredoc
  ENV['RAILS_ENV'] ||= 'test'

  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter 'app/channels'
    add_filter 'app/mailers'
    add_filter 'app/jobs'
    add_filter 'lib'
  end

  require_relative '../config/environment'
  require 'rails/test_help'
  require 'webmock/minitest'
  # require 'minitest/unit'
  require 'mocha/minitest'

  WebMock.disable_net_connect!

  class ActiveSupport::TestCase
    # parallelize(workers: :number_of_processors)
    fixtures :all
  end
end
